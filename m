Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275863AbRJGARn>; Sat, 6 Oct 2001 20:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275963AbRJGARd>; Sat, 6 Oct 2001 20:17:33 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:56850 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S275863AbRJGARS>;
	Sat, 6 Oct 2001 20:17:18 -0400
Message-ID: <3BBF9F69.8090405@si.rr.com>
Date: Sat, 06 Oct 2001 20:18:49 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] 2.4.10-ac7: MODULE_LICENSE additions
Content-Type: multipart/mixed;
 boundary="------------030503030502020909010701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030503030502020909010701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
    I have attached a few MODULE_LICENSE patches against 2.4.10-ac7 . 
Please review.
Regards,
Frank

--------------030503030502020909010701
Content-Type: text/plain;
 name="IDE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE"

--- drivers/ide/ide.c.old	Sun Sep 30 20:38:42 2001
+++ drivers/ide/ide.c	Sat Oct  6 19:51:34 2001
@@ -3747,6 +3747,7 @@
 #ifdef MODULE
 char *options = NULL;
 MODULE_PARM(options,"s");
+MODULE_LICENSE("GPL");
 
 static void __init parse_options (char *line)
 {

--------------030503030502020909010701
Content-Type: text/plain;
 name="SOCAL"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SOCAL"

--- drivers/fc4/socal.c.old	Sun Sep 30 20:38:40 2001
+++ drivers/fc4/socal.c	Sat Oct  6 19:34:25 2001
@@ -904,3 +904,4 @@
 
 module_init(socal_probe);
 module_exit(socal_cleanup);
+MODULE_LICENSE("GPL");

--------------030503030502020909010701
Content-Type: text/plain;
 name="SOC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SOC"

--- drivers/fc4/soc.c.old	Sun Sep 30 20:38:40 2001
+++ drivers/fc4/soc.c	Sat Oct  6 19:32:38 2001
@@ -764,3 +764,4 @@
 
 module_init(soc_probe);
 module_exit(soc_cleanup);
+MODULE_LICENSE("GPL");

--------------030503030502020909010701
Content-Type: text/plain;
 name="IDE-FLOP"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE-FLOP"

--- drivers/ide/ide-floppy.c.old	Sun Sep 30 20:38:42 2001
+++ drivers/ide/ide-floppy.c	Sat Oct  6 19:58:31 2001
@@ -2116,3 +2116,4 @@
 
 module_init(idefloppy_init);
 module_exit(idefloppy_exit);
+MODULE_LICENSE("GPL");

--------------030503030502020909010701
Content-Type: text/plain;
 name="IDE-PROB"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE-PROB"

--- drivers/ide/ide-probe.c.old	Fri Oct  5 23:03:36 2001
+++ drivers/ide/ide-probe.c	Sat Oct  6 19:48:00 2001
@@ -928,4 +928,5 @@
 {
 	ide_probe = NULL;
 }
+MODULE_LICENSE("GPL");
 #endif /* MODULE */

--------------030503030502020909010701
Content-Type: text/plain;
 name="MOUSE_RP"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MOUSE_RP"

--- drivers/acorn/char/mouse_rpc.c.old	Wed Jun 27 17:12:04 2001
+++ drivers/acorn/char/mouse_rpc.c	Sat Oct  6 19:18:50 2001
@@ -83,3 +83,4 @@
 
 module_init(mouse_rpc_init);
 module_exit(mouse_rpc_exit);
+MODULE_LICENSE("GPL");

--------------030503030502020909010701
Content-Type: text/plain;
 name="RAPIDE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="RAPIDE"

--- drivers/ide/rapide.c.old	Wed Jun 27 17:12:04 2001
+++ drivers/ide/rapide.c	Sat Oct  6 19:54:16 2001
@@ -69,6 +69,7 @@
 }
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
 
 int init_module (void)
 {

--------------030503030502020909010701
Content-Type: text/plain;
 name="I2C-PROC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="I2C-PROC"

--- drivers/i2c/i2c-proc.c.old	Fri Oct  5 23:03:34 2001
+++ drivers/i2c/i2c-proc.c	Sat Oct  6 19:38:09 2001
@@ -883,6 +883,7 @@
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("i2c-proc driver");
+MODULE_LICENSE("GPL");
 
 int i2c_cleanup(void)
 {
@@ -902,5 +903,4 @@
 {
 	return i2c_cleanup();
 }
-
 #endif				/* MODULE */

--------------030503030502020909010701--

