Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270333AbRIGBBT>; Thu, 6 Sep 2001 21:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270339AbRIGBBK>; Thu, 6 Sep 2001 21:01:10 -0400
Received: from ns1.hicom.net ([208.245.180.8]:26886 "EHLO ns1.hicom.net")
	by vger.kernel.org with ESMTP id <S270333AbRIGBBC>;
	Thu, 6 Sep 2001 21:01:02 -0400
Message-Id: <200109070101.VAA01649@ns1.hicom.net>
Subject: RedHat-diald no go?
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
From: stevon@hicom.net
Cc: dave@guardiandigital.com
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
X-Sender-ip: 0d5f6b79
Date: Thu, 6 Sep 2001 21:01 +0100
X-mailer: Netbula AnyEMail(TM) 4.69 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having problems using RedHat 7.1 (2.4.3-12) and diald
(0.99.4) on my Linux server. When I see "SIGTERM" and "SIGINT"
I get very nervous. Has anyone got diald to work since 1996? 
if so, Heeeeeeeeeeeeeeeeeeeelp!
This is what happens when diald tries to connect to my ISP
after receiving a http request:  (/var/log/messages)

Sep 6 19:10:40 stevon diald[1430]: accept parcing error. Got token 'tcp.www'. Not a known tcp service port.
Sep 6 19:10:40 stevon diald[1430]: parse string: 'tcp 240 tcp.dest=tcp.www'
Sep 6 19:10:40 stevon diald[1430]: accept parcing error. Got token 'tcp.www'. Not a known tcp
service port. 
Sep 6 19:10:40 stevon diald[1430]: parse string: 'tcp 240 tcp.dest=tcp.www'
Sep 6 19:10:40 stevon diald[1430]: accept parcing error. Got token 'tcp.www'. Not a known tcp
service port. 
Sep 6 19:10:40 stevon diald[1430]: parse string: 'udp udp.dest=udp.route'
Sep 6 19:10:40 stevon diald[1430]: accept parcing error. Got token 'udp.route'. Not a known udp service port.
Sep 6 19:10:40 stevon diald[1430]: parse string: 'udp udp.dest=udp.route'
Sep 6 19:10:40 stevon diald[1430]: accept parcing error. Got token 'udp.route'. Not a known udp service port.
Sep 6 19:10:40 stevon diald[1430]: parse string: 'udp udp.dest=udp.route'
Sep 6 19:10:40 stevon diald[1430]: accept parcing error. Got token 'udp.route'. Not a known udp service port.
Sep 6 19:10:40 stevon diald[1430]: parse string: 'udp tcp.source=udp.route'
Sep 6 19:10:40 stevon diald startup succedded
Sep 6 19:10:40 stevon modprobe: modprobe: can't locate module tap 0
Sep 6 19:10:40 stevon modprobe: modprobe: can't locate module tap 1
Sep 6 19:10:40 stevon modprobe: modprobe: can't locate module tap 2
Sep 6 19:10:40 stevon modprobe: modprobe: can't locate module tap 3
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 4
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 5
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 6
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 7
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 8
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 9
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 10
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 11
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 12
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 13
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 14
Sep 6 19:10:41 stevon modprobe: modprobe: can't locate module tap 15
Sep 6 19:10:42 stevon kernel: SLIP: version 0.8.4-NET3.019-NEWTTY-MODULAR (dynamic channels, max=256) (6 bit encapsulation enabled)
Sep 6 19:10:42 stevon /etc/hotplug/net.agent: register event not handled
Sep 6 19:11:05 stevon diald[1430]: Trigger: udp 10.0.0.1/1024  208.245.180.2/53
Sep 6 19:11:05 stevon diald[1430]: Calling site 10.0.0.2
Sep 6 19:11:07 stevon Kernel: PPP generic driver version 2.4.1 
Sep 6 19:11:07 stevon pppd[925]: 2.4.0 started by root, uid 0
Sep 6 19:11:07 stevon chat[926]: report (CONNECT) 
Sep 6 19:11:07 stevon chat[926]: abort on (NO CARRIER)
Sep 6 19:11:07 stevon chat[926]: abort on (BUSY)
Sep 6 19:11:07 stevon chat[926]: abort on (NO DIAL TONE)
Sep 6 19:11:07 stevon chat[926]: send (ATZ^M)
Sep 6 19:11:07 stevon chat[926]: expect (OK)
Sep 6 19:11:07 stevon chat[926]: ATZ^M^M
Sep 6 19:11:07 stevon chat[926]: OK
Sep 6 19:11:08 stevon chat[926]:  -- got it
Sep 6 19:11:08 stevon chat[926]: send (ATDT305-8585^M)
Sep 6 19:11:08 stevon chat[926]: Timeout set to 240 seconds
Sep 6 19:11:08 stevon chat[926]: expect (CONNECT)
Sep 6 19:10:08 stevon chat[926]: ^M
Sep 6 19:11:25 stevon chat[926]: ATDT305-8585^M^M
Sep 6 19:11:25 stevon chat[926]: CONNECT
Sep 6 19:11:25 stevon chat[926]:  -- got it
Sep 6 19:11:25 stevon chat[926]: send (^M)
Sep 6 19:11:25 stevon chat[926]: expect (ogin:)
Sep 6 19:11:25 stevon chat[926]:  115200^M
Sep 6 19:11:26 stevon chat[926]: ^M
Sep 6 19:11:26 stevon chat[926]: LOGIN:
Sep 6 19:11:26 stevon chat[926]:  -- got it
Sep 6 19:11:26 stevon chat[926]: send (stevon^M)
Sep 6 19:11:26 stevon chat[926]: expect (word:)
Sep 6 19:11:26 stevon chat[926]:  stevon^M
Sep 6 19:11:26 stevon chat[926]: Password:
Sep 6 19:11:26 stevon chat[926]:  -- got it
Sep 6 19:11:26 stevon chat[926]: send (chubb^M)
Sep 6 19:11:27 stevon chat[925]: Serial connection established
Sep 6 19:11:27 stevon chat[925]: Using interface ppp0
Sep 6 19:11:27 stevon chat[925]: Connect: pppp0 <--> /dev/ttyS3
Sep 6 19:11:31 stevon su(pam_unix)[1498] session opened for user root by (uid=0)
Sep 6 19:11:31 stevon su(pam_unix)[1498] session closed for user root
Sep 6 19:12:05 stevon Kernel: PPP Deflate compression module registered
Sep 6 19:12:05 stevon pppd[1537]: not replacing existing default route to sl0 [0.0.0.0]
Sep 6 19:12:05 stevon pppd[1509]: local IP address 208.245.180.85
Sep 6 19:12:05 stevon pppd[1509]: remote IP address 208.245.180.7
Sep 6 19:12:05 stevon diald[1431]: Connect script timed out. Killing script.
Sep 6 19:12:05 stevon pppd[1509]: Terminating on signal 2
Sep 6 19:12:05 stevon pppd[925]: Connection terminated.
Sep 6 19:12:05 stevon pppd[925]: Connect time 1.5 minutes
Sep 6 19:12:05 stevon pppd[925]: Sent 3136 bytes, recieved 3040 bytes.
Sep 6 19:12:07 stevon pppd[925]: Exit
Sep 6 19:12:08 stevon su(pam_unix)[1498] session opened for user root by (uid=0)
Sep 6 19:12:08 stevon su(pam_unix)[1498] session closed for user root
Sep 6 19:12:09 stevon diald[1431]: Delaying 10 seconds before clear to dial
Sep 6 19:12:20 stevon diald[1431]: Calling site 10.0.0.2
Sep 6 19:12:22 stevon pppd[1581]: 2.4.0 started by root, uid 0
Sep 6 19:12:22 stevon chat[1582]: report (CONNECT) 
Sep 6 19:12:22 stevon chat[1582]: abort on (NO CARRIER)
Sep 6 19:12:22 stevon chat[1582]: abort on (BUSY)
Sep 6 19:12:22 stevon chat[1582]: abort on (NO DIAL TONE)
Sep 1 11:31:26 stevon chat[1582]: send (ATZ^M)
Sep 6 19:12:22 stevon chat[1582]: expect (OK)
Sep 6 19:12:22 stevon chat[1582]: ATZ^M^M
Sep 6 19:12:22 stevon chat[1582]: OK
Sep 6 19:12:22 stevon chat[1582]:  -- got it
Sep 6 19:12:22 stevon chat[1582]: send (ATDT305-8585^M)
Sep 6 19:12:22 stevon chat[1582]: Timeout set to 240 seconds
Sep 6 19:12:22 stevon chat[1582]: expect (CONNECT)
Sep 6 19:12:22 stevon chat[1582]: ^M
Sep 6 19:12:24 diald [1431]: SIGTERM. Termination request received.
Sep 6 19:12:24 diald [1431]: Diald is dieing with code 0
Sep 6 19:12:24 stevon pppd[1581]: Terminating on signal 2
Sep 6 19:12:24 stevon chat[1582]: SIGINT
Sep 6 19:12:24 stevon pppd[1581]: connect script failed
Sep 6 19:12:25 stevon pppd[1581]: Exit

running pppd and my chat script I have no problems maintaining
a connection to my ISP. It's just when diald runs, it initates 
it's son of a #$%@&$#%!! sl0 loop, that everything goes wrong.

please personally CC the answers/comments to stevon@hicom.net 

-------------------
Email sent using AnyEmail from http://www.hicom.net

