Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUBONlP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 08:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUBONlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 08:41:15 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28361 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264903AbUBONlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 08:41:14 -0500
Date: Sun, 15 Feb 2004 14:41:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] update FB_RADEON help text
Message-ID: <20040215134108.GU1308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FB_RADEON_I2C selects I2C_ALGOBIT.

cu
Adrian

--- linux-2.6.3-rc3-full/drivers/video/Kconfig.old	2004-02-15 14:31:08.000000000 +0100
+++ linux-2.6.3-rc3-full/drivers/video/Kconfig	2004-02-15 14:31:56.000000000 +0100
@@ -622,12 +622,8 @@
 	  a framebuffer device.  There are both PCI and AGP versions.  You
 	  don't need to choose this to run the Radeon in plain VGA mode.
 
-	  If you say Y here and want DDC/I2C support you must first say Y to
-	  "I2C support" and "I2C bit-banging support" in the character devices
-	  section.
-
-	  If you say M here then "I2C support" and "I2C bit-banging support" 
-	  can be build either as modules or built-in.
+	  If you say Y here and want DDC/I2C support you must first enable
+	  "I2C support" in the character devices section.
 
 	  There is a product page at
 	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
