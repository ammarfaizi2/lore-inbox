Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277196AbRJNR7Y>; Sun, 14 Oct 2001 13:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277263AbRJNR7O>; Sun, 14 Oct 2001 13:59:14 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:8201 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S277261AbRJNR7C>;
	Sun, 14 Oct 2001 13:59:02 -0400
Message-ID: <3BC9D2C7.1020903@si.rr.com>
Date: Sun, 14 Oct 2001 14:00:39 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.12-ac1: last of drivers/net MODULE_LICENSE patches
Content-Type: multipart/mixed;
 boundary="------------020406010706050809030309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020406010706050809030309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
    I have attached a few more (last of them, I hope :) ) drivers/net 
MODULE_LICENSE patches. Please review.
Regards,
Frank

--------------020406010706050809030309
Content-Type: text/plain;
 name="MAC89X0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MAC89X0"

--- drivers/net/mac89x0.c.old	Fri Oct 12 18:37:15 2001
+++ drivers/net/mac89x0.c	Sun Oct 14 13:37:22 2001
@@ -627,6 +627,7 @@
 
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "CS89[02]0 debug level (0-5)");
+MODULE_LICENSE("GPL");
 
 EXPORT_NO_SYMBOLS;
 

--------------020406010706050809030309
Content-Type: text/plain;
 name="MACE"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MACE"

--- drivers/net/mace.c.old	Wed Jun 20 14:10:53 2001
+++ drivers/net/mace.c	Sun Oct 14 13:38:24 2001
@@ -913,6 +913,7 @@
 
 MODULE_AUTHOR("Paul Mackerras");
 MODULE_DESCRIPTION("PowerMac MACE driver.");
+MODULE_LICENSE("GPL");
 
 static void __exit mace_cleanup (void)
 {

--------------020406010706050809030309
Content-Type: text/plain;
 name="MACSONIC"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MACSONIC"

--- drivers/net/macsonic.c.old	Fri Oct 12 18:42:55 2001
+++ drivers/net/macsonic.c	Sun Oct 14 13:39:20 2001
@@ -584,6 +584,7 @@
 
 MODULE_PARM(sonic_debug, "i");
 MODULE_PARM_DESC(sonic_debug, "macsonic debug level (1-4)");
+MODULE_LICENSE("GPL");
 
 EXPORT_NO_SYMBOLS;
 

--------------020406010706050809030309
Content-Type: text/plain;
 name="MVME147"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MVME147"

--- drivers/net/mvme147.c.old	Thu Apr 12 15:15:25 2001
+++ drivers/net/mvme147.c	Sun Oct 14 13:40:30 2001
@@ -188,6 +188,8 @@
 }
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
+
 int init_module(void)
 {
 	root_lance_dev = NULL;

--------------020406010706050809030309
Content-Type: text/plain;
 name="MYRI_SBU"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MYRI_SBU"

--- drivers/net/myri_sbus.c.old	Thu Apr 19 12:34:52 2001
+++ drivers/net/myri_sbus.c	Sun Oct 14 13:41:37 2001
@@ -1153,3 +1153,4 @@
 
 module_init(myri_sbus_probe);
 module_exit(myri_sbus_cleanup);
+MODULE_LICENSE("GPL");

--------------020406010706050809030309--

