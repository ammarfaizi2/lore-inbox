Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVEJOMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVEJOMU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 10:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVEJOMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 10:12:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38366 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261659AbVEJOMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 10:12:17 -0400
Date: Tue, 10 May 2005 09:12:07 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pci_ids: LPC bus id used in TPM driver
Message-ID: <Pine.LNX.4.62.0505100908230.6421@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply this patch which adds an LPC ID to the pci_ids file.  The TPM 
device driver is using this id.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc3/include/linux/pci_ids.h	2005-04-20 17:03:16.000000000 -0700
+++ linux-2.6.12-rc3/include/linux/pci_ids.h	2005-05-03 12:34:15.000000000 -0700
@@ -1559,6 +1562,7 @@
 #define PCI_DEVICE_ID_SERVERWORKS_OSB4USB 0x0220
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5USB PCI_DEVICE_ID_SERVERWORKS_OSB4USB
 #define PCI_DEVICE_ID_SERVERWORKS_CSB6USB 0x0221
+#define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_GCLE    0x0225
 #define PCI_DEVICE_ID_SERVERWORKS_GCLE2   0x0227
 #define PCI_DEVICE_ID_SERVERWORKS_CSB5ISA 0x0230
