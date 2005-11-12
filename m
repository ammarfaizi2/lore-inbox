Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVKLOTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVKLOTb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVKLOTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:19:31 -0500
Received: from atlantis.8hz.com ([212.129.237.78]:56801 "EHLO atlantis.8hz.com")
	by vger.kernel.org with ESMTP id S932381AbVKLOTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:19:31 -0500
Date: Sat, 12 Nov 2005 15:19:29 +0100
From: Sean Young <sean@mess.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc1 [PATCH] MTD_TS5500 Kconfig
Message-ID: <20051112141929.GA25124@atlantis.8hz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ELAN does not exist any more.

Signed-off-by: Sean Young <sean@mess.org>
--- 
diff -uprN a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
--- a/drivers/mtd/maps/Kconfig	2005-11-12 13:52:48.000000000 +0100
+++ b/drivers/mtd/maps/Kconfig	2005-11-12 13:52:02.000000000 +0100
@@ -94,7 +94,7 @@ config MTD_NETSC520
 
 config MTD_TS5500
 	tristate "JEDEC Flash device mapped on Technologic Systems TS-5500"
-	depends on ELAN
+	depends on X86
 	select MTD_PARTITIONS
 	select MTD_JEDECPROBE
 	select MTD_CFI_AMDSTD
