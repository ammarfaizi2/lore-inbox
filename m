Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276639AbRJGTpq>; Sun, 7 Oct 2001 15:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276632AbRJGTpg>; Sun, 7 Oct 2001 15:45:36 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:6931 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S276643AbRJGTpV>;
	Sun, 7 Oct 2001 15:45:21 -0400
Message-ID: <3BC0B12F.3010207@si.rr.com>
Date: Sun, 07 Oct 2001 15:46:55 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.4.10-ac7: more drivers/parport MODULE_LICENSE patches
Content-Type: multipart/mixed;
 boundary="------------080504010609070205060908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080504010609070205060908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
   I have attached 3 more drivers/parport MODULE_LICENSE patches. Please 
review.
Regards,
Frank

--------------080504010609070205060908
Content-Type: text/plain;
 name="PARPORT3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PARPORT3"

--- drivers/parport/parport_gsc.c.old	Tue May 22 22:54:04 2001
+++ drivers/parport/parport_gsc.c	Sun Oct  7 12:50:40 2001
@@ -554,3 +554,4 @@
 
 module_init(parport_gsc_init_module);
 module_exit(parport_gsc_exit_module);
+MODULE_LICENSE("GPL");

--------------080504010609070205060908
Content-Type: text/plain;
 name="PARPORT4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PARPORT4"

--- drivers/parport/parport_sunbpp.c.old	Mon Jun 11 22:15:27 2001
+++ drivers/parport/parport_sunbpp.c	Sun Oct  7 12:32:35 2001
@@ -367,6 +367,8 @@
 EXPORT_NO_SYMBOLS;
 
 #ifdef MODULE
+MODULE_LICENSE("GPL");
+
 int init_module(void)
 #else
 int __init parport_sunbpp_init(void)

--------------080504010609070205060908
Content-Type: text/plain;
 name="PARPORT5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="PARPORT5"

--- drivers/parport/parport_mfc3.c.old	Tue May 22 22:54:04 2001
+++ drivers/parport/parport_mfc3.c	Sun Oct  7 12:52:17 2001
@@ -408,6 +408,7 @@
 MODULE_AUTHOR("Joerg Dorchain <joerg@dorchain.net>");
 MODULE_DESCRIPTION("Parport Driver for Multiface 3 expansion cards Paralllel Port");
 MODULE_SUPPORTED_DEVICE("Multiface 3 Parallel Port");
+MODULE_LICENSE("GPL");
 
 module_init(parport_mfc3_init)
 module_exit(parport_mfc3_exit)

--------------080504010609070205060908--

