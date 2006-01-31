Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751515AbWAaVdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbWAaVdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWAaVdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:33:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19215 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751510AbWAaVdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:33:01 -0500
Date: Tue, 31 Jan 2006 22:32:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI_AACRAID: add a help text
Message-ID: <20060131213257.GE3986@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the text by Mark Salyzyn <mark_salyzyn@adaptec.com>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/Kconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.16-rc1-mm4-full/drivers/scsi/Kconfig.old	2006-01-31 21:18:27.000000000 +0100
+++ linux-2.6.16-rc1-mm4-full/drivers/scsi/Kconfig	2006-01-31 21:19:48.000000000 +0100
@@ -381,6 +381,14 @@
 config SCSI_AACRAID
 	tristate "Adaptec AACRAID support"
 	depends on SCSI && PCI
+	help
+	  This driver supports a variety of Dell, HP, Adaptec, IBM and
+	  ICP storage products. For a list of supported products, refer
+	  to <file:Documentation/scsi/aacraid.txt>.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called aacraid.
+
 
 source "drivers/scsi/aic7xxx/Kconfig.aic7xxx"
 

