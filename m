Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVA0KsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVA0KsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVA0Kkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:40:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14861 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262567AbVA0KZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:25:35 -0500
Date: Thu, 27 Jan 2005 11:25:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Romain =?iso-8859-1?Q?Li=E9vin?= <roms@lievin.net>
Subject: [2.6 patch] update the =?iso-8859-1?Q?emai?=
	=?iso-8859-1?Q?l_address_of_Romain_Li=E9vin?=
Message-ID: <20050127102530.GC28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates a bouncing email address of Romain Liévin.
It was already ACK'ed by Romain Liévin.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/tipar.txt          |    2 +-
 Documentation/usb/silverlink.txt |    2 +-
 MAINTAINERS                      |    4 ++--
 drivers/char/tipar.c             |    4 ++--
 include/linux/ticable.h          |    2 +-
 scripts/kconfig/gconf.c          |    2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc2-mm1-full/Documentation/tipar.txt.old	2005-01-24 23:49:38.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/Documentation/tipar.txt	2005-01-24 23:50:19.000000000 +0100
@@ -83,7 +83,7 @@
 
 HOW TO CONTACT US:
 
-You can email me at roms@lpg.ticalc.org. Please prefix the subject line
+You can email me at roms@tilp.info. Please prefix the subject line
 with "TIPAR: " so that I am certain to notice your message.
 You can also mail JB at jb@jblache.org. He packaged these drivers for Debian.
 
--- linux-2.6.11-rc2-mm1-full/Documentation/usb/silverlink.txt.old	2005-01-24 23:50:30.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/Documentation/usb/silverlink.txt	2005-01-24 23:50:35.000000000 +0100
@@ -67,7 +67,7 @@
 
 HOW TO CONTACT US:
 
-You can email me at roms@lpg.ticalc.org. Please prefix the subject line
+You can email me at roms@tilp.info. Please prefix the subject line
 with "TIGLUSB: " so that I am certain to notice your message.
 You can also mail JB at jb@jblache.org: he has written the first release of 
 this driver but he better knows the Mac OS-X driver.
--- linux-2.6.11-rc2-mm1-full/MAINTAINERS.old	2005-01-24 23:50:43.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/MAINTAINERS	2005-01-24 23:50:49.000000000 +0100
@@ -2236,14 +2236,14 @@
 
 TI GRAPH LINK USB (SilverLink) CABLE DRIVER
 P:	Romain Lievin
-M:	roms@lpg.ticalc.org
+M:	roms@tilp.info
 P:	Julien Blache
 M:	jb@technologeek.org
 S:	Maintained
 
 TI PARALLEL LINK CABLE DRIVER
 P:     Romain Lievin
-M:     roms@lpg.ticalc.org
+M:     roms@tilp.info
 S:     Maintained
 
 TLAN NETWORK DRIVER
--- linux-2.6.11-rc2-mm1-full/drivers/char/tipar.c.old	2005-01-24 23:51:09.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/drivers/char/tipar.c	2005-01-24 23:51:13.000000000 +0100
@@ -4,7 +4,7 @@
  * for Texas Instruments graphing calculators (http://lpg.ticalc.org).
  * A part of the TiLP project.
  *
- * Copyright (C) 2000-2002, Romain Lievin <roms@lpg.ticalc.org>
+ * Copyright (C) 2000-2002, Romain Lievin <roms@tilp.info>
  * under the terms of the GNU General Public License.
  *
  * Various fixes & clean-up from the Linux Kernel Mailing List
@@ -69,7 +69,7 @@
  * Version Information
  */
 #define DRIVER_VERSION "1.19"
-#define DRIVER_AUTHOR  "Romain Lievin <roms@lpg.ticalc.org>"
+#define DRIVER_AUTHOR  "Romain Lievin <roms@tilp.info>"
 #define DRIVER_DESC    "Device driver for TI/PC parallel link cables"
 #define DRIVER_LICENSE "GPL"
 
--- linux-2.6.11-rc2-mm1-full/include/linux/ticable.h.old	2005-01-24 23:51:32.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/include/linux/ticable.h	2005-01-24 23:51:40.000000000 +0100
@@ -3,7 +3,7 @@
  * tipar/tiser/tiusb - low level driver for handling link cables
  * designed for Texas Instruments graphing calculators.
  *
- * Copyright (C) 2000-2002, Romain Lievin <roms@lpg.ticalc.org>
+ * Copyright (C) 2000-2002, Romain Lievin <roms@tilp.info>
  *
  * Redistribution of this file is permitted under the terms of the GNU
  * Public License (GPL)
--- linux-2.6.11-rc2-mm1-full/scripts/kconfig/gconf.c.old	2005-01-24 23:51:48.000000000 +0100
+++ linux-2.6.11-rc2-mm1-full/scripts/kconfig/gconf.c	2005-01-24 23:51:53.000000000 +0100
@@ -741,7 +741,7 @@
 {
 	GtkWidget *dialog;
 	const gchar *about_text =
-	    "gkc is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
+	    "gkc is copyright (c) 2002 Romain Lievin <roms@tilp.info>.\n"
 	    "Based on the source code from Roman Zippel.\n";
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),


