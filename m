Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbWHOJVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbWHOJVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965329AbWHOJVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:21:47 -0400
Received: from outmx014.isp.belgacom.be ([195.238.4.69]:16824 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S965326AbWHOJVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:21:46 -0400
Date: Tue, 15 Aug 2006 11:21:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [WATCHDOG] v2.6.18-rc4 Kconfig typos patch
Message-ID: <20060815092139.GA3668@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog.git

This will update the following files:

 drivers/char/watchdog/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

with these Changes:

Author: Matt LaPlante <kernel1@cyberdogtech.com>
Date:   Wed Jul 5 01:20:51 2006 +0000

    [WATCHDOG] Kconfig typos fix.
    
    Three typos in drivers/char/watchdog/Kconfig...
    
    Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

The Changes can also be looked at on:
	http://www.kernel.org/git/?p=linux/kernel/git/wim/linux-2.6-watchdog.git;a=summary

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/drivers/char/watchdog/Kconfig b/drivers/char/watchdog/Kconfig
index d53f664..fff89c2 100644
--- a/drivers/char/watchdog/Kconfig
+++ b/drivers/char/watchdog/Kconfig
@@ -45,7 +45,7 @@ #
 comment "Watchdog Device Drivers"
 	depends on WATCHDOG
 
-# Architecture Independant
+# Architecture Independent
 
 config SOFT_WATCHDOG
 	tristate "Software watchdog"
@@ -127,7 +127,7 @@ config S3C2410_WATCHDOG
 	  enabled.
 
 	  The driver is limited by the speed of the system's PCLK
-	  signal, so with reasonbaly fast systems (PCLK around 50-66MHz)
+	  signal, so with reasonably fast systems (PCLK around 50-66MHz)
 	  then watchdog intervals of over approximately 20seconds are
 	  unavailable.
 
@@ -423,7 +423,7 @@ config SBC_EPX_C3_WATCHDOG
 	  is no way to know if writing to its IO address will corrupt
 	  your system or have any real effect.  The only way to be sure
 	  that this driver does what you want is to make sure you
-	  are runnning it on an EPX-C3 from Winsystems with the watchdog
+	  are running it on an EPX-C3 from Winsystems with the watchdog
 	  timer at IO address 0x1ee and 0x1ef.  It will write to both those
 	  IO ports.  Basically, the assumption is made that if you compile
 	  this driver into your kernel and/or load it as a module, that you
@@ -472,7 +472,7 @@ config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
 	depends on WATCHDOG && SGI_IP22
 	help
-	  Hardwaredriver for the Indy's/I2's watchdog. This is a
+	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
 	  timer expired and no process has written to /dev/watchdog during
 	  that time.
