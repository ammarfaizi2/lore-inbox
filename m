Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTHTIXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTHTINF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:13:05 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:64717 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261822AbTHTIFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:05:18 -0400
Date: Wed, 20 Aug 2003 18:06:27 +1000
Message-Id: <200308200806.h7K86REv011813@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 16/16] C99: 2.6.0-t3-bk7/sound
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/sound/oss/ite8172.c linux/sound/oss/ite8172.c
--- linux.backup/sound/oss/ite8172.c	Wed Aug 20 16:39:02 2003
+++ linux/sound/oss/ite8172.c	Wed Aug 20 16:40:22 2003
@@ -2198,10 +2198,10 @@
 MODULE_DEVICE_TABLE(pci, id_table);
 
 static struct pci_driver it8172_driver = {
-	name: IT8172_MODULE_NAME,
-	id_table: id_table,
-	probe: it8172_probe,
-	remove: it8172_remove
+	.name = IT8172_MODULE_NAME,
+	.id_table = id_table,
+	.probe = it8172_probe,
+	.remove = it8172_remove
 };
 
 static int __init init_it8172(void)
