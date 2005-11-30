Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbVK3ABA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVK3ABA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 19:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVK3ABA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 19:01:00 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:36035 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751415AbVK3AA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 19:00:56 -0500
Date: Wed, 30 Nov 2005 01:00:55 +0100 (MET)
From: Richard Knutsson <ricknu-0@student.ltu.se>
To: linux-kernel@vger.kernel.org
Cc: Richard Knutsson <ricknu-0@student.ltu.se>
Message-Id: <20051130000605.1009.82993.sendpatchset@thinktank.campus.ltu.se>
In-Reply-To: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
References: <20051130000425.1009.94647.sendpatchset@thinktank.campus.ltu.se>
Subject: [PATCH 6/6] pci.h: Delete Replace pci_module_init()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Knutsson <ricknu-0@student.ltu.se>

Deleting no-longer-needed pci_module_init().

Need previous patches in the serie to be implemented.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 pci.h |    6 ------
 1 files changed, 6 deletions(-)

diff -Narup a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-11-29 11:09:05.000000000 +0100
+++ b/include/linux/pci.h	2005-11-29 19:14:07.000000000 +0100
@@ -277,12 +277,6 @@ struct pci_driver {
 	.vendor = PCI_ANY_ID, .device = PCI_ANY_ID, \
 	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
 
-/*
- * pci_module_init is obsolete, this stays here till we fix up all usages of it
- * in the tree.
- */
-#define pci_module_init	pci_register_driver
-
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
