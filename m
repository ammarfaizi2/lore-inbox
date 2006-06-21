Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWFUO3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWFUO3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWFUO2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:28:31 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:61856 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S1751600AbWFUO0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:26:37 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH 18/21] [PCI] Add SDHCI controller ids
Date: Wed, 21 Jun 2006 16:26:36 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060621142636.8857.24436.stgit@poseidon.drzeus.cx>
In-Reply-To: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
References: <20060621142323.8857.69197.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ids for SDHCI controllers so that they can be identified for quirks.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 include/linux/pci_ids.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index bcfe9d4..6ef38b4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -725,6 +725,7 @@ #define PCI_VENDOR_ID_TI		0x104c
 #define PCI_DEVICE_ID_TI_TVP4020	0x3d07
 #define PCI_DEVICE_ID_TI_4450		0x8011
 #define PCI_DEVICE_ID_TI_XX21_XX11	0x8031
+#define PCI_DEVICE_ID_TI_XX21_XX11_SD	0x8034
 #define PCI_DEVICE_ID_TI_X515		0x8036
 #define PCI_DEVICE_ID_TI_1130		0xac12
 #define PCI_DEVICE_ID_TI_1031		0xac13
@@ -1422,6 +1423,7 @@ #define PCI_DEVICE_ID_RICOH_RL5C466	0x04
 #define PCI_DEVICE_ID_RICOH_RL5C475	0x0475
 #define PCI_DEVICE_ID_RICOH_RL5C476	0x0476
 #define PCI_DEVICE_ID_RICOH_RL5C478	0x0478
+#define PCI_DEVICE_ID_RICOH_R5C822	0x0822
 
 #define PCI_VENDOR_ID_DLINK		0x1186
 #define PCI_DEVICE_ID_DLINK_DGE510T	0x4c00

