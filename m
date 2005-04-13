Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVDMXuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVDMXuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVDMXuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:50:16 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:36104 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261236AbVDMXoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:44:55 -0400
Date: Wed, 13 Apr 2005 19:38:44 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Cc: jgarzik@pobox.com, davem@davemloft.net
Subject: [patch 2.6.12-rc2 3/10] tg3: add bcm5752 entry to pci_ids.h
Message-ID: <04132005193844.8474@laptop>
In-Reply-To: <04132005193844.8410@laptop>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper entry for bcm5752 PCI ID to pci_ids.h, and use it in tg3.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
I did this separately in case patches like this (i.e. new PCI IDs)
need to come from more "official" sources.

 drivers/net/tg3.c       |    2 +-
 include/linux/pci_ids.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- bcm5752-support/drivers/net/tg3.c.orig	2005-04-08 17:35:34.834372048 -0400
+++ bcm5752-support/drivers/net/tg3.c	2005-04-08 17:34:42.536563710 -0400
@@ -206,7 +206,7 @@ static struct pci_device_id tg3_pci_tbl[
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5751F,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
-	{ PCI_VENDOR_ID_BROADCOM, 0x1600, /* TIGON3_5752 */
+	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5752,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_TIGON3_5753,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
--- bcm5752-support/include/linux/pci_ids.h.orig	2005-04-08 17:30:45.655140363 -0400
+++ bcm5752-support/include/linux/pci_ids.h	2005-04-08 17:31:52.965883217 -0400
@@ -2065,6 +2065,7 @@
 #define PCI_DEVICE_ID_AFAVLAB_P030	0x2182
 
 #define PCI_VENDOR_ID_BROADCOM		0x14e4
+#define PCI_DEVICE_ID_TIGON3_5752	0x1600
 #define PCI_DEVICE_ID_TIGON3_5700	0x1644
 #define PCI_DEVICE_ID_TIGON3_5701	0x1645
 #define PCI_DEVICE_ID_TIGON3_5702	0x1646
