Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273403AbTHFCpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273906AbTHFCpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:45:46 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:18336
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S273403AbTHFCpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:45:44 -0400
Date: Tue, 5 Aug 2003 22:45:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: PATCH 2.6: intel ich5 irq router, pci ids
Message-ID: <20030806024544.GA1296@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===== arch/i386/pci/irq.c 1.28 vs edited =====
--- 1.28/arch/i386/pci/irq.c	Thu Jul 31 19:47:19 2003
+++ edited/arch/i386/pci/irq.c	Tue Aug  5 22:35:31 2003
@@ -474,6 +474,8 @@
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_12, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0, pirq_piix_get, pirq_piix_set },
 	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0, pirq_piix_get, pirq_piix_set },
+	{ "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_0, pirq_piix_get, pirq_piix_set },
 
 	{ "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
 
===== include/linux/pci_ids.h 1.111 vs edited =====
--- 1.111/include/linux/pci_ids.h	Wed Jul 23 16:42:11 2003
+++ edited/include/linux/pci_ids.h	Tue Aug  5 22:37:33 2003
@@ -1931,6 +1931,20 @@
 #define PCI_DEVICE_ID_INTEL_82801EB_7	0x24d7
 #define PCI_DEVICE_ID_INTEL_82801EB_11	0x24db
 #define PCI_DEVICE_ID_INTEL_82801EB_13	0x24dd
+#define PCI_DEVICE_ID_INTEL_ESB_0	0x25a0
+#define PCI_DEVICE_ID_INTEL_ESB_1	0x25a1
+#define PCI_DEVICE_ID_INTEL_ESB_2	0x25a2
+#define PCI_DEVICE_ID_INTEL_ESB_3	0x25a3
+#define PCI_DEVICE_ID_INTEL_ESB_31	0x25b0
+#define PCI_DEVICE_ID_INTEL_ESB_4	0x25a4
+#define PCI_DEVICE_ID_INTEL_ESB_5	0x25a6
+#define PCI_DEVICE_ID_INTEL_ESB_6	0x25a7
+#define PCI_DEVICE_ID_INTEL_ESB_7	0x25a9
+#define PCI_DEVICE_ID_INTEL_ESB_8	0x25aa
+#define PCI_DEVICE_ID_INTEL_ESB_9	0x25ab
+#define PCI_DEVICE_ID_INTEL_ESB_11	0x25ac
+#define PCI_DEVICE_ID_INTEL_ESB_12	0x25ad
+#define PCI_DEVICE_ID_INTEL_ESB_13	0x25ae
 #define PCI_DEVICE_ID_INTEL_82820_HB	0x2500
 #define PCI_DEVICE_ID_INTEL_82820_UP_HB	0x2501
 #define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
