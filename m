Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVHWVnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVHWVnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVHWVnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:182 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932423AbVHWVnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:43:08 -0400
To: torvalds@osdl.org
Subject: [PATCH] (17/43) Kconfig fix (acornscsi)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gax-0007BB-JP@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:46:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

acornscsi had been broken for a long time; marked as such

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-8390/drivers/scsi/arm/Kconfig RC13-rc6-git13-acornscsi/drivers/scsi/arm/Kconfig
--- RC13-rc6-git13-8390/drivers/scsi/arm/Kconfig	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-acornscsi/drivers/scsi/arm/Kconfig	2005-08-21 13:17:01.000000000 -0400
@@ -3,7 +3,7 @@
 #
 config SCSI_ACORNSCSI_3
 	tristate "Acorn SCSI card (aka30) support"
-	depends on ARCH_ACORN && SCSI
+	depends on ARCH_ACORN && SCSI && BROKEN
 	help
 	  This enables support for the Acorn SCSI card (aka30). If you have an
 	  Acorn system with one of these, say Y. If unsure, say N.
