Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWBBWGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWBBWGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWBBWGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:06:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17425 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932335AbWBBWGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:06:50 -0500
Date: Thu, 2 Feb 2006 23:06:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: petero2@telia.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let CDROM_PKTCDVD_WCACHE depend on EXPERIMENTAL
Message-ID: <20060202220643.GE14097@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless the help text is outdated, this seems to be logical.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm4-full/drivers/block/Kconfig.old	2006-02-02 22:39:24.000000000 +0100
+++ linux-2.6.16-rc1-mm4-full/drivers/block/Kconfig	2006-02-02 22:39:51.000000000 +0100
@@ -437,8 +437,8 @@
 	  pktsetup time.
 
 config CDROM_PKTCDVD_WCACHE
-	bool "Enable write caching"
-	depends on CDROM_PKTCDVD
+	bool "Enable write caching (EXPERIMENTAL)"
+	depends on CDROM_PKTCDVD && EXPERIMENTAL
 	help
 	  If enabled, write caching will be set for the CD-R/W device. For now
 	  this option is dangerous unless the CD-RW media is known good, as we

