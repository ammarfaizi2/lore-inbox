Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268593AbUHLPv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268593AbUHLPv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 11:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268595AbUHLPv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 11:51:28 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:13034 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S268593AbUHLPvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 11:51:06 -0400
Subject: [PATCH] Remove whitespace from ALI15x3 IDE driver name
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org
Message-Id: <1092336877.7433.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 18:54:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes whitespace from ALI15x3 IDE driver name that appears in the
sysfs directory. It is against 2.6.7.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

 alim15x3.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.7-pe/drivers/ide/pci/alim15x3.c
===================================================================
--- linux-2.6.7-pe.orig/drivers/ide/pci/alim15x3.c	2004-08-05 17:28:15.000000000 +0000
+++ linux-2.6.7-pe/drivers/ide/pci/alim15x3.c	2004-08-12 16:45:22.774205576 +0000
@@ -893,7 +893,7 @@
 MODULE_DEVICE_TABLE(pci, alim15x3_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "ALI15x3 IDE",
+	.name		= "ALI15x3_IDE",
 	.id_table	= alim15x3_pci_tbl,
 	.probe		= alim15x3_init_one,
 };


