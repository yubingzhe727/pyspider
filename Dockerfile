FROM cmfatih/phantomjs
MAINTAINER binux <roy@binux.me>
ENV TZ "Asia/Shanghai"
# install python
RUN apt-get update && \
        apt-get install -y python python-dev python-distribute python-pip && \
        apt-get install -y libcurl4-openssl-dev libxml2-dev libxslt1-dev python-lxml python-mysqldb libmysqld-dev libmysqlclient-dev

# install requirements
ADD requirements.txt /opt/pyspider/requirements.txt
RUN pip install -r /opt/pyspider/requirements.txt
RUN pip install -U pip
RUN pip install MySQL-python

# add all repo
ADD ./ /opt/pyspider

# run test
WORKDIR /opt/pyspider
RUN pip install -e .[all]

VOLUME ["/opt/pyspider"]
ENTRYPOINT ["pyspider"]

EXPOSE 5000 23333 24444 25555
