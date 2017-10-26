# Use an official Python runtime as a parent image
FROM jupyterhub/jupyterhub

# Set the working directory to /app


# Copy the current directory contents into the container at /app
ADD nuttcp /usr/bin/

# Install any needed packages specified in requirements.txt
RUN apt-get -y update && \
    apt-get install -y tar gzip pciutils gcc iperf3 iftop fio && \
    /opt/conda/bin/pip install paramiko psutil numpy pymongo netifaces matplotlib notebook jupyterhub && \
    /opt/conda/bin/pip install --upgrade pip
RUN useradd -ms /bin/bash icair && \
    echo 'icair:starlight' | chpasswd
WORKDIR /home/icair
RUN git clone https://github.com/waue0920/DTN_monitor.git  && \
    chown -R icair:icair /home/icair

# Make port 80 available to the world outside this container
EXPOSE 8000

# Define environment variable
#ENV NAME World
#ENV http_proxy host:port
#ENV https_proxy host:port

# Run app.py when the container launches
CMD ["jupyterhub"]
