Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbVKSWfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbVKSWfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 17:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbVKSWfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 17:35:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37382 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750981AbVKSWfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 17:35:22 -0500
Date: Sat, 19 Nov 2005 23:35:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Subject: [2.6 patch] SCSI_AACRAID: add a help text
Message-ID: <20051119223519.GT16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Mark Salyzyn <aacraid@adaptec.com>

--- linux-2.6.15-rc1-mm2-full/drivers/scsi/Kconfig.old	2005-11-19 23:33:04.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/drivers/scsi/Kconfig	2005-11-19 23:33:07.000000000 +0100
@@ -402,6 +402,14 @@
 config SCSI_AACRAID
 	tristate "Adaptec AACRAID support"
 	depends on SCSI && PCI
+	help
+	  This driver supports the Dell PERC2, 2/Si, 3/Si, 3/Di,
+	  CERC, HP NetRAID-4M SCSI, Adaptec Advanced Raid Products
+	  <http://www.adaptec.com/products/solutions/raid.html>
+	  late model IBM ServeRAID and ICP SATA & SAS products.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called aacraid.
 
 source "drivers/scsi/aic94xx/Kconfig"
 
