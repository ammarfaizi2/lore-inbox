Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWCDMOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWCDMOT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 07:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWCDMOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 07:14:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17168 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751526AbWCDMOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 07:14:18 -0500
Date: Sat, 4 Mar 2006 13:14:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove dead Radeon URL
Message-ID: <20060304121417.GJ9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a dead Radeon URL from two Kconfig files.

This isue was noted by Reto Gantenbein <ganto82@gmx.ch> in
Kernel Bugzilla #4446.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/drm/Kconfig |    4 ++--
 drivers/video/Kconfig    |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc5-mm2-full/drivers/char/drm/Kconfig.old	2006-03-03 17:17:44.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/drivers/char/drm/Kconfig	2006-03-03 17:18:00.000000000 +0100
@@ -37,8 +37,8 @@
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
-	  run the Radeon in plain VGA mode.  There is a product page at
-	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
+	  run the Radeon in plain VGA mode.
+	  
 	  If M is selected, the module will be called radeon.
 
 config DRM_I810
--- linux-2.6.16-rc5-mm2-full/drivers/video/Kconfig.old	2006-03-03 17:18:23.000000000 +0100
+++ linux-2.6.16-rc5-mm2-full/drivers/video/Kconfig	2006-03-03 17:18:33.000000000 +0100
@@ -915,8 +915,6 @@
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You
 	  don't need to choose this to run the Radeon in plain VGA mode.
-	  There is a product page at
-	  <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.
 
 config FB_RADEON
 	tristate "ATI Radeon display support"

