Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTJDUVA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 16:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbTJDUVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 16:21:00 -0400
Received: from mail.convergence.de ([212.84.236.4]:56717 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262740AbTJDUU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 16:20:57 -0400
Message-ID: <3F7F2BA1.1010009@convergence.de>
Date: Sat, 04 Oct 2003 22:20:49 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6] MAINTAINERS, CREDITS, ioctl-number.txt updates
Content-Type: multipart/mixed;
 boundary="------------070708020201090102050400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070708020201090102050400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

I forgot to CC LKML in my post, so here it comes...

CU
Michael.

-------------------------schnipp---------------------------------------
Hi Linus,

this patch updates the following files:

- MAINTAINERS:
    - add the LinuxTV.org project as the DVB driver maintainer
    - add me as the saa7146 v4l2 driver maintainer
- CREDITS: add me as the saa7146 v4l2 driver author
- Documentation/ioctl-number.txt:
    - remove bogus reference to Linux DVD API, which never really existed
    - remove bogus referenc to Philips saa7146 driver, which never came
to life

I've sent the changes for "ioctl-number.txt" to Marcello for 2.4
inclusion, too.

Thanks
Michael.
-------------------------schnipp---------------------------------------


--------------070708020201090102050400
Content-Type: text/plain;
 name="documentation_update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="documentation_update.diff"

diff -ura xx-linux-2.6.0-test6/CREDITS linux-2.6.0-test6/CREDITS
--- xx-linux-2.6.0-test6/CREDITS	2003-10-04 21:06:38.000000000 +0200
+++ linux-2.6.0-test6/CREDITS	2003-10-04 21:29:59.000000000 +0200
@@ -1459,6 +1459,13 @@
 S: Roscommon
 S: Ireland
 
+N: Michael Hunold
+E: michael@mihu.de
+W: http://www.mihu.de/linux/
+D: Generic saa7146 video4linux-2 driver core,
+D: Driver for the "Multimedia eXtension Board", "dpc7146",
+D: "Hexium Orion", "Hexium Gemini"
+
 N: Miguel de Icaza Amozurrutia
 E: miguel@nuclecu.unam.mx
 D: Linux/SPARC team, Midnight Commander maintainer
diff -ura xx-linux-2.6.0-test6/Documentation/ioctl-number.txt linux-2.6.0-test6/Documentation/ioctl-number.txt
--- xx-linux-2.6.0-test6/Documentation/ioctl-number.txt	2003-10-04 21:06:09.000000000 +0200
+++ linux-2.6.0-test6/Documentation/ioctl-number.txt	2003-10-04 21:26:50.000000000 +0200
@@ -175,10 +175,6 @@
 					<mailto:buk@buks.ipn.de>
 0xA0	all	linux/sdp/sdp.h		Industrial Device Project
 					<mailto:kenji@bitgate.com>
-0xA2    00-0F   DVD decoder driver      in development:
-                                        <http://linuxtv.org/developer/dvdapi.html>
-0xA3	00-1F	Philips SAA7146 dirver	in development:
-					<mailto:Andreas.Beckmann@hamburg.sc.philips.com>
 0xA3	80-8F	Port ACL		in development:
 					<mailto:tlewis@mindspring.com>
 0xA3	90-9F	linux/dtlk.h
diff -ura xx-linux-2.6.0-test6/MAINTAINERS linux-2.6.0-test6/MAINTAINERS
--- xx-linux-2.6.0-test6/MAINTAINERS	2003-10-04 21:06:38.000000000 +0200
+++ linux-2.6.0-test6/MAINTAINERS	2003-10-04 21:17:14.000000000 +0200
@@ -669,6 +669,12 @@
 M:	romieu@ensta.fr
 S:	Maintained
 
+DVB SUBSYSTEM AND DRIVERS
+P:	LinuxTV.org Project
+L: 	linux-dvb@linuxtv.org
+W:	http://linuxtv.org/developer/dvb.xml
+S:	Supported
+
 EATA-DMA SCSI DRIVER
 P:	Michael Neuffer
 L:	linux-eata@i-connect.net, linux-scsi@vger.kernel.org
@@ -1658,6 +1664,12 @@
 W:	http://oss.software.ibm.com/developerworks/opensource/linux390
 S:	Supported
 
+SAA7146 VIDEO4LINUX-2 DRIVER
+P:	Michael Hunold
+M:	michael@mihu.de
+W:	http://www.mihu.de/linux/saa7146
+S:	Maintained
+
 SA1100 SUPPORT
 P:	Nicolas Pitre
 M:	nico@cam.org


--------------070708020201090102050400--

