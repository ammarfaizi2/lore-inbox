Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWGEBVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWGEBVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 21:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWGEBVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 21:21:31 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:10765 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S932408AbWGEBVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 21:21:30 -0400
Date: Tue, 4 Jul 2006 21:20:51 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH] drivers/char/watchdog/Kconfig typos
Message-Id: <20060704212051.0daf98c3.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Tue, 04 Jul 2006 21:20:55 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Tue, 04 Jul 2006 21:20:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three typos in drivers/char/watchdog/Kconfig...

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
kernel1@cyberdogtech.com

--

--- a/drivers/char/watchdog/Kconfig	2006-06-17 21:49:35.000000000 -0400
+++ b/drivers/char/watchdog/Kconfig	2006-07-04 21:12:33.000000000 -0400
@@ -45,7 +45,7 @@
 comment "Watchdog Device Drivers"
 	depends on WATCHDOG
 
-# Architecture Independant
+# Architecture Independent
 
 config SOFT_WATCHDOG
 	tristate "Software watchdog"
@@ -127,7 +127,7 @@
 	  enabled.
 
 	  The driver is limited by the speed of the system's PCLK
-	  signal, so with reasonbaly fast systems (PCLK around 50-66MHz)
+	  signal, so with reasonably fast systems (PCLK around 50-66MHz)
 	  then watchdog intervals of over approximately 20seconds are
 	  unavailable.
 
@@ -423,7 +423,7 @@
 	  is no way to know if writing to its IO address will corrupt
 	  your system or have any real effect.  The only way to be sure
 	  that this driver does what you want is to make sure you
-	  are runnning it on an EPX-C3 from Winsystems with the watchdog
+	  are running it on an EPX-C3 from Winsystems with the watchdog
 	  timer at IO address 0x1ee and 0x1ef.  It will write to both those
 	  IO ports.  Basically, the assumption is made that if you compile
 	  this driver into your kernel and/or load it as a module, that you
@@ -472,7 +472,7 @@
 	tristate "Indy/I2 Hardware Watchdog"
 	depends on WATCHDOG && SGI_IP22
 	help
-	  Hardwaredriver for the Indy's/I2's watchdog. This is a
+	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
 	  timer expired and no process has written to /dev/watchdog during
 	  that time.

