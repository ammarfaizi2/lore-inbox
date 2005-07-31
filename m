Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVGaBn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVGaBn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 21:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVGaBnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 21:43:25 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:20433 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261236AbVGaBnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 21:43:24 -0400
From: Grant Coady <lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6: fix PCI_DEVIEC_ID_APPLE_UNI_N_ATA spelling
Date: Sun, 31 Jul 2005 11:43:14 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <4paoe15uf06alspjmroo1m7bbvatmjcrf7@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Patch to fix PCI_DEVIEC_ID_APPLE_UNI_N_ATA spelling.



Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 drivers/ide/ppc/pmac.c  |    2 +-
 include/linux/pci_ids.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -X dontdiff -Nrup linux-2.6.13-rc4-git2/drivers/ide/ppc/pmac.c linux-2.6.13-rc4-git2a/drivers/ide/ppc/pmac.c
--- linux-2.6.13-rc4-git2/drivers/ide/ppc/pmac.c	2005-07-31 11:32:18.000000000 +1000
+++ linux-2.6.13-rc4-git2a/drivers/ide/ppc/pmac.c	2005-07-31 11:32:53.000000000 +1000
@@ -1664,7 +1664,7 @@ static struct macio_driver pmac_ide_maci
 };
 
 static struct pci_device_id pmac_ide_pci_match[] = {
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVIEC_ID_APPLE_UNI_N_ATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_ATA,
diff -X dontdiff -Nrup linux-2.6.13-rc4-git2/include/linux/pci_ids.h linux-2.6.13-rc4-git2a/include/linux/pci_ids.h
--- linux-2.6.13-rc4-git2/include/linux/pci_ids.h	2005-07-31 11:32:18.000000000 +1000
+++ linux-2.6.13-rc4-git2a/include/linux/pci_ids.h	2005-07-31 11:32:53.000000000 +1000
@@ -581,7 +581,7 @@
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP15	0x002d
 #define PCI_DEVICE_ID_APPLE_UNI_N_PCI15	0x002e
 #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC2	0x0032
-#define PCI_DEVIEC_ID_APPLE_UNI_N_ATA	0x0033
+#define PCI_DEVICE_ID_APPLE_UNI_N_ATA	0x0033
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP2	0x0034
 #define PCI_DEVICE_ID_APPLE_IPID_ATA100	0x003b
 #define PCI_DEVICE_ID_APPLE_K2_ATA100	0x0043
