Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUCDNmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUCDNlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:41:31 -0500
Received: from mail.math.uni-mannheim.de ([134.155.89.179]:14030 "EHLO
	mail.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261900AbUCDNk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:40:57 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Change "GPL" to "GPL v2" where files are GPLv2
Date: Thu, 4 Mar 2004 08:44:52 +0100
User-Agent: KMail/1.6
References: <200403040838.31412.eike-kernel@sf-tec.de>
In-Reply-To: <200403040838.31412.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403040840.13086.eike-kernel@sf-tec.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-there is a tag only for "GPL v2" but there are some drivers claiming to be
>v2 and not using this (patch will follow)

And here it is.

diff -aur linux-2.6.3/drivers/message/fusion/isense.c 
linux-2.6.3-eike/drivers/message/fusion/isense.c
--- linux-2.6.3/drivers/message/fusion/isense.c	2004-02-18 04:57:56.000000000 
+0100
+++ linux-2.6.3-eike/drivers/message/fusion/isense.c	2004-03-04 
08:04:14.000000000 +0100
@@ -91,7 +91,7 @@
 
 MODULE_AUTHOR(MODULEAUTHOR);
 MODULE_DESCRIPTION(my_NAME);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 int __init isense_init(void)
diff -aur linux-2.6.3/drivers/message/fusion/mptbase.c 
linux-2.6.3-eike/drivers/message/fusion/mptbase.c
--- linux-2.6.3/drivers/message/fusion/mptbase.c	2004-03-04 
08:19:02.000000000 +0100
+++ linux-2.6.3-eike/drivers/message/fusion/mptbase.c	2004-03-04 
08:02:32.000000000 +0100
@@ -118,7 +118,7 @@
 
 MODULE_AUTHOR(MODULEAUTHOR);
 MODULE_DESCRIPTION(my_NAME);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 
 /*
  *  cmd line parameters
diff -aur linux-2.6.3/drivers/message/fusion/mptctl.c 
linux-2.6.3-eike/drivers/message/fusion/mptctl.c
--- linux-2.6.3/drivers/message/fusion/mptctl.c	2004-02-18 04:57:13.000000000 
+0100
+++ linux-2.6.3-eike/drivers/message/fusion/mptctl.c	2004-03-04 
08:01:39.000000000 +0100
@@ -106,7 +106,7 @@
 #endif
 MODULE_AUTHOR(MODULEAUTHOR);
 MODULE_DESCRIPTION(my_NAME);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 
diff -aur linux-2.6.3/drivers/message/fusion/mptlan.c 
linux-2.6.3-eike/drivers/message/fusion/mptlan.c
--- linux-2.6.3/drivers/message/fusion/mptlan.c	2004-03-04 08:19:02.000000000 
+0100
+++ linux-2.6.3-eike/drivers/message/fusion/mptlan.c	2004-03-04 
08:05:00.000000000 +0100
@@ -80,7 +80,7 @@
 
 #define MYNAM		"mptlan"
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*
diff -aur linux-2.6.3/drivers/message/fusion/mptscsih.c 
linux-2.6.3-eike/drivers/message/fusion/mptscsih.c
--- linux-2.6.3/drivers/message/fusion/mptscsih.c	2004-03-04 
08:19:02.000000000 +0100
+++ linux-2.6.3-eike/drivers/message/fusion/mptscsih.c	2004-03-04 
08:03:05.000000000 +0100
@@ -89,7 +89,7 @@
 
 MODULE_AUTHOR(MODULEAUTHOR);
 MODULE_DESCRIPTION(my_NAME);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 
 /* Set string for command line args from insmod */
 #ifdef MODULE
diff -aur linux-2.6.3/drivers/pci/hotplug/fakephp.c 
linux-2.6.3-eike/drivers/pci/hotplug/fakephp.c
--- linux-2.6.3/drivers/pci/hotplug/fakephp.c	2004-02-18 04:58:36.000000000 
+0100
+++ linux-2.6.3-eike/drivers/pci/hotplug/fakephp.c	2004-03-04 
07:49:33.000000000 +0100
@@ -226,7 +226,7 @@
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 
diff -aur linux-2.6.3/drivers/scsi/3w-xxxx.c 
linux-2.6.3-eike/drivers/scsi/3w-xxxx.c
--- linux-2.6.3/drivers/scsi/3w-xxxx.c	2004-02-18 04:59:31.000000000 +0100
+++ linux-2.6.3-eike/drivers/scsi/3w-xxxx.c	2004-03-04 07:59:08.000000000 
+0100
@@ -189,7 +189,7 @@
 #else
 MODULE_DESCRIPTION ("3ware Storage Controller Linux Driver");
 #endif
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 
 #include <linux/kernel.h>
 #include <linux/pci.h>
diff -aur linux-2.6.3/drivers/usb/serial/usb-serial.c 
linux-2.6.3-eike/drivers/usb/serial/usb-serial.c
--- linux-2.6.3/drivers/usb/serial/usb-serial.c	2004-02-18 04:57:31.000000000 
+0100
+++ linux-2.6.3-eike/drivers/usb/serial/usb-serial.c	2004-03-02 
09:54:22.000000000 +0100
@@ -1468,7 +1468,7 @@
 /* Module information */
 MODULE_AUTHOR( DRIVER_AUTHOR );
 MODULE_DESCRIPTION( DRIVER_DESC );
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "Debug enabled or not");
