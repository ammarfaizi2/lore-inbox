Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276736AbRJHBPW>; Sun, 7 Oct 2001 21:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276738AbRJHBPO>; Sun, 7 Oct 2001 21:15:14 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:38670 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S276736AbRJHBO5>;
	Sun, 7 Oct 2001 21:14:57 -0400
Message-ID: <3BC0FE4B.6010901@si.rr.com>
Date: Sun, 07 Oct 2001 21:15:55 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, alan <alan@redhat.com>
Subject: [PATCH] 2.4.10-ac8: drivers/sbus MODULE_LICENSE additions
Content-Type: multipart/mixed;
 boundary="------------090804080707020809040309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090804080707020809040309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   I have attached a few drivers/sbus MODULE_LICENSE patches. Please 
review. Thanks.
Regards,
Frank

--------------090804080707020809040309
Content-Type: text/plain;
 name="AUDIO"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="AUDIO"

--- drivers/sbus/audio/audio.c.old	Mon Aug 27 11:53:11 2001
+++ drivers/sbus/audio/audio.c	Sun Oct  7 20:13:15 2001
@@ -2138,8 +2138,9 @@
 	devfs_unregister (devfs_handle);
 }
 
-module_init(sparcaudio_init)
-module_exit(sparcaudio_exit)
+module_init(sparcaudio_init);
+module_exit(sparcaudio_exit);
+MODULE_LICENSE("GPL");
 
 /*
  * Code from Linux Streams, Copyright 1995 by

--------------090804080707020809040309
Content-Type: text/plain;
 name="AURORA"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="AURORA"

--- drivers/sbus/char/aurora.c.old	Mon Aug 27 11:53:11 2001
+++ drivers/sbus/char/aurora.c	Sun Oct  7 20:49:50 2001
@@ -2482,3 +2482,4 @@
 
 module_init(aurora_init);
 module_exit(aurora_cleanup);
+MODULE_LICENSE("GPL");

--------------090804080707020809040309
Content-Type: text/plain;
 name="BPP"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="BPP"

--- drivers/sbus/char/bpp.c.old	Mon Jan 22 16:30:20 2001
+++ drivers/sbus/char/bpp.c	Sun Oct  7 20:47:04 2001
@@ -1073,3 +1073,4 @@
 
 module_init(bpp_init);
 module_exit(bpp_cleanup);
+MODULE_LICENSE("GPL");

--------------090804080707020809040309
Content-Type: text/plain;
 name="CPWATCHD"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CPWATCHD"

--- drivers/sbus/char/cpwatchdog.c.old	Thu Apr 12 15:10:25 2001
+++ drivers/sbus/char/cpwatchdog.c	Sun Oct  7 20:45:52 2001
@@ -193,6 +193,7 @@
 	("Eric Brower <ebrower@usa.net>");
 MODULE_DESCRIPTION
 	("Hardware watchdog driver for Sun Microsystems CP1400/1500");
+MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE
 	("watchdog");
 #endif /* ifdef MODULE */

--------------090804080707020809040309
Content-Type: text/plain;
 name="CS4231"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CS4231"

--- drivers/sbus/audio/cs4231.c.old	Mon Jun 11 22:15:27 2001
+++ drivers/sbus/audio/cs4231.c	Sun Oct  7 20:11:48 2001
@@ -2443,6 +2443,7 @@
 
 module_init(cs4231_init);
 module_exit(cs4231_exit);
+MODULE_LICENSE("GPL");
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

--------------090804080707020809040309
Content-Type: text/plain;
 name="DBRI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DBRI"

--- drivers/sbus/audio/dbri.c.old	Mon Jun 11 22:15:27 2001
+++ drivers/sbus/audio/dbri.c	Sun Oct  7 20:18:49 2001
@@ -2377,6 +2377,8 @@
 
 module_init(dbri_init);
 module_exit(dbri_exit);
+MODULE_LICENSE("GPL");
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

--------------090804080707020809040309
Content-Type: text/plain;
 name="DISPLAY7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DISPLAY7"

--- drivers/sbus/char/display7seg.c.old	Thu Nov  9 18:57:41 2000
+++ drivers/sbus/char/display7seg.c	Sun Oct  7 20:44:40 2001
@@ -55,6 +55,7 @@
 	("Eric Brower <ebrower@usa.net>");
 MODULE_DESCRIPTION
 	("7-Segment Display driver for Sun Microsystems CP1400/1500");
+MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE
 	("d7s");
 #endif /* ifdef MODULE */

--------------090804080707020809040309
Content-Type: text/plain;
 name="DMY"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMY"

--- drivers/sbus/audio/dmy.c.old	Mon Jun 11 22:15:27 2001
+++ drivers/sbus/audio/dmy.c	Sun Oct  7 20:16:59 2001
@@ -783,6 +783,8 @@
 
 module_init(dummy_init);
 module_exit(dummy_exit);
+MODULE_LICENSE("GPL");
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

--------------090804080707020809040309
Content-Type: text/plain;
 name="ENVCTRL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ENVCTRL"

--- drivers/sbus/char/envctrl.c.old	Mon Aug 27 11:53:11 2001
+++ drivers/sbus/char/envctrl.c	Sun Oct  7 20:43:17 2001
@@ -1175,3 +1175,4 @@
 
 module_init(envctrl_init);
 module_exit(envctrl_cleanup);
+MODULE_LICENSE("GPL");

--------------090804080707020809040309
Content-Type: text/plain;
 name="FLASH"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="FLASH"

--- drivers/sbus/char/flash.c.old	Wed Mar  7 01:44:16 2001
+++ drivers/sbus/char/flash.c	Sun Oct  7 20:41:17 2001
@@ -247,3 +247,4 @@
 
 module_init(flash_init);
 module_exit(flash_cleanup);
+MODULE_LICENSE("GPL");

--------------090804080707020809040309
Content-Type: text/plain;
 name="ISENSE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ISENSE"

--- drivers/message/fusion/isense.c.old	Sun Sep 30 20:38:51 2001
+++ drivers/message/fusion/isense.c	Sun Oct  7 20:05:35 2001
@@ -87,6 +87,7 @@
 EXPORT_NO_SYMBOLS;
 MODULE_AUTHOR(MODULEAUTHOR);
 MODULE_DESCRIPTION(my_NAME);
+MODULE_LICENSE("GPL");
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 int __init isense_init(void)

--------------090804080707020809040309
Content-Type: text/plain;
 name="JSFLASH"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="JSFLASH"

--- drivers/sbus/char/jsflash.c.old	Sun Sep 30 20:39:17 2001
+++ drivers/sbus/char/jsflash.c	Sun Oct  7 20:38:21 2001
@@ -682,6 +682,7 @@
 }
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
 
 int init_module(void) {
 	int rc;

--------------090804080707020809040309
Content-Type: text/plain;
 name="OPENPROM"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="OPENPROM"

--- drivers/sbus/char/openprom.c.old	Mon Aug 27 11:53:11 2001
+++ drivers/sbus/char/openprom.c	Sun Oct  7 20:36:23 2001
@@ -653,3 +653,4 @@
 
 module_init(openprom_init);
 module_exit(openprom_cleanup);
+MODULE_LICENSE("GPL");

--------------090804080707020809040309
Content-Type: text/plain;
 name="RIOWATCH"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RIOWATCH"

--- drivers/sbus/char/riowatchdog.c.old	Thu Apr 12 15:10:25 2001
+++ drivers/sbus/char/riowatchdog.c	Sun Oct  7 20:33:19 2001
@@ -47,6 +47,7 @@
 MODULE_AUTHOR("David S. Miller <davem@redhat.com>");
 MODULE_DESCRIPTION("Hardware watchdog driver for Sun RIO");
 MODULE_SUPPORTED_DEVICE("watchdog");
+MODULE_LICENSE("GPL");
 
 #define RIOWD_NAME	"pmc"
 #define RIOWD_MINOR	215

--------------090804080707020809040309
Content-Type: text/plain;
 name="RTC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RTC"

--- drivers/sbus/char/rtc.c.old	Mon Aug 27 11:53:11 2001
+++ drivers/sbus/char/rtc.c	Sun Oct  7 20:29:23 2001
@@ -174,3 +174,4 @@
 
 module_init(rtc_sun_init);
 module_exit(rtc_sun_cleanup);
+MODULE_LICENSE("GPL");

--------------090804080707020809040309
Content-Type: text/plain;
 name="SAB82532"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SAB82532"

--- drivers/sbus/char/sab82532.c.old	Fri Jun 29 22:38:26 2001
+++ drivers/sbus/char/sab82532.c	Sun Oct  7 20:27:46 2001
@@ -2427,6 +2427,8 @@
 }
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
+
 int init_module(void)
 {
 	if (get_sab82532(0))

--------------090804080707020809040309
Content-Type: text/plain;
 name="UCTRL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="UCTRL"

--- drivers/sbus/char/uctrl.c.old	Mon Aug 27 11:53:12 2001
+++ drivers/sbus/char/uctrl.c	Sun Oct  7 20:24:24 2001
@@ -424,3 +424,4 @@
 
 module_init(ts102_uctrl_init);
 module_exit(ts102_uctrl_cleanup);
+MODULE_LICENSE("GPL");

--------------090804080707020809040309--

