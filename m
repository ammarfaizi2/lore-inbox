Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278062AbRJIXmf>; Tue, 9 Oct 2001 19:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278063AbRJIXmZ>; Tue, 9 Oct 2001 19:42:25 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:3082 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S278062AbRJIXmJ>;
	Tue, 9 Oct 2001 19:42:09 -0400
Message-ID: <3BC38BA4.1010005@si.rr.com>
Date: Tue, 09 Oct 2001 19:43:32 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, alan <alan@redhat.com>
Subject: [PATCH] 2.4.10-ac10: drivers/char MODULE_LICENSE patches
Content-Type: multipart/mixed;
 boundary="------------030806060901030207030407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030806060901030207030407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   I've attached MODULE_LICENSE patches for drivers/char files . Please 
review.
Regards,
Frank

--------------030806060901030207030407
Content-Type: text/plain;
 name="I810_RNG"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="I810_RNG"

--- drivers/char/i810_rng.c.old	Thu Apr 12 15:15:25 2001
+++ drivers/char/i810_rng.c	Tue Oct  9 18:53:40 2001
@@ -342,6 +342,7 @@
 
 MODULE_AUTHOR("Jeff Garzik, Philipp Rumpf, Matt Sottek");
 MODULE_DESCRIPTION("Intel i8xx chipset Random Number Generator (RNG) driver");
+MODULE_LICENSE("GPL");
 
 
 /*

--------------030806060901030207030407
Content-Type: text/plain;
 name="IB700WDT"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IB700WDT"

--- drivers/char/ib700wdt.c.old	Mon Oct  8 18:23:58 2001
+++ drivers/char/ib700wdt.c	Tue Oct  9 18:55:47 2001
@@ -267,5 +267,6 @@
 
 MODULE_AUTHOR("Charles Howes <chowes@vsol.net>");
 MODULE_DESCRIPTION("IB700 SBC watchdog driver");
+MODULE_LICENSE("GPL");
 
 /* end of ib700wdt.c */

--------------030806060901030207030407
Content-Type: text/plain;
 name="SH-SCI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SH-SCI"

--- drivers/char/sh-sci.c.old	Sun Sep 30 20:38:37 2001
+++ drivers/char/sh-sci.c	Tue Oct  9 19:08:42 2001
@@ -90,6 +90,7 @@
 
 #ifdef MODULE
 MODULE_PARM(sci_debug, "i");
+MODULE_LICENSE("GPL");
 #endif
 
 #define dprintk(x...) do { if (sci_debug) printk(x); } while(0)

--------------030806060901030207030407--

