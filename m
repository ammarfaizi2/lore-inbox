Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270622AbTHJVah (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270703AbTHJVah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:30:37 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:58610 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S270622AbTHJVa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:30:27 -0400
Message-ID: <3F36BA33.3070605@wanadoo.fr>
Date: Sun, 10 Aug 2003 23:33:39 +0200
From: =?ISO-8859-1?Q?R=E9mi_Colinet?= <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3(-mm1) : Alcatel USB speedtouch modem unusable
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the Alcatel USB ADSL speedtouch modem with the user space 
driver. It was running fine with 2.6.0-test2 (and older kernel).

[root@tigre01 root]# Using interface ppp0
Connect: ppp0 <--> /dev/pts/4
Remote message: CHAP authentication success, unit 405
local  IP address 193.253.203.209
remote IP address 193.253.203.1
primary   DNS address 193.252.19.3
secondary DNS address 193.252.19.4

Now,  something seems to be broken with 2.6.0-test3 (and 2.6.0-test3-mm1)

[root@tigre01 root]# Using interface ppp0
Connect: ppp0 <--> /dev/pts/2
Modem hangup
Connection terminated.
Using interface ppp0
Connect: ppp0 <--> /dev/pts/2
Child process /usr/local/bin/pppoa2 -vpi 8 -vci 35 -d 
/proc/bus/usb/001/002 (pid 1080) terminated with signal 2
Child process /usr/local/bin/pppoa2 -vpi 8 -vci 35 -d 
/proc/bus/usb/001/002 (pid 1084) terminated with signal 2
Modem hangup
Connection terminated.
Using interface ppp0
Connect: ppp0 <--> /dev/pts/2
Modem hangup
Connection terminated.
Using interface ppp0
Connect: ppp0 <--> /dev/pts/2
Child process /usr/local/bin/pppoa2 -vpi 8 -vci 35 -d 
/proc/bus/usb/001/002 (pid 1088) terminated with signal 2
Modem hangup
Connection terminated.
Using interface ppp0
Connect: ppp0 <--> /dev/pts/2
Child process /usr/local/bin/pppoa2 -vpi 8 -vci 35 -d 
/proc/bus/usb/001/002 (pid 1092) terminated with signal 2
Modem hangup
Connection terminated.
Using interface ppp0
Connect: ppp0 <--> /dev/pts/2

I didn't change anything to my configuration and to my .config file.
Any idea?   

Remi

