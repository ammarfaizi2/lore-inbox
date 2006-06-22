Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWFVNIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWFVNIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWFVNIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:08:19 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:905 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1030251AbWFVNIS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:08:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 2/13] SST driver: PCI ids
Date: Thu, 22 Jun 2006 09:08:18 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B710F6@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 2/13] SST driver: PCI ids
Thread-Index: AcaV/O2rPb08YpOKQjOzGn/u113K7w==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 2: Adds Equinox specific vendor id and SST specific device ids to
PCI
id table.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 pci_ids.h |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/include/linux/pci_ids.h
linux-2.6.17.eqnx/include/linux/pci_ids.h
--- linux-2.6.17/include/linux/pci_ids.h	2006-06-17
21:49:35.000000000 -0400
+++ linux-2.6.17.eqnx/include/linux/pci_ids.h	2006-06-20
09:49:55.000000000 -0400
@@ -1347,6 +1347,36 @@
 #define PCI_VENDOR_ID_ZIATECH		0x1138
 #define PCI_DEVICE_ID_ZIATECH_5550_HC	0x5550
  
+#define PCI_VENDOR_ID_EQNX		0x113f
+#define PCI_DEVICE_ID_EQNX_SST64P	0x0808
+#define PCI_DEVICE_ID_EQNX_SST128P	0x1010
+#define PCI_DEVICE_ID_EQNX_SST8PRJ	0x8814
+#define PCI_DEVICE_ID_EQNX_SST8PRJ2	0x9014
+#define PCI_DEVICE_ID_EQNX_SST64PHP	0x0868
+#define PCI_DEVICE_ID_EQNX_SST128PHP	0x1070
+#define PCI_DEVICE_ID_EQNX_SST4P	0x8888
+#define PCI_DEVICE_ID_EQNX_SST4PRJ	0x888C
+#define PCI_DEVICE_ID_EQNX_SST8P	0x9090
+#define PCI_DEVICE_ID_EQNX_SST8PRJ3	0x9094
+#define PCI_DEVICE_ID_EQNX_SSTMM8P	0x9898
+#define PCI_DEVICE_ID_EQNX_SSTMM4P	0x989C
+#define PCI_DEVICE_ID_EQNX_SST4PC8	0x88A0
+#define PCI_DEVICE_ID_EQNX_SST4PC4	0x88A4
+#define PCI_DEVICE_ID_EQNX_SST2P	0x88A8
+#define PCI_DEVICE_ID_EQNX_SST4PC0	0x88AC
+#define PCI_DEVICE_ID_EQNX_SST8PC8	0x90B0
+#define PCI_DEVICE_ID_EQNX_SST8PC4	0x90B4
+#define PCI_DEVICE_ID_EQNX_SST4PLP	0x88B8
+#define PCI_DEVICE_ID_EQNX_SST8PC0	0x90BC
+#define PCI_DEVICE_ID_EQNX_SST16PDB	0x80C0
+#define PCI_DEVICE_ID_EQNX_SST16PRJ	0x80C4
+#define PCI_DEVICE_ID_EQNX_SST16PNP	0x80C8
+#define PCI_DEVICE_ID_EQNX_SST16PDB9	0x80D0
+#define PCI_DEVICE_ID_EQNX_SST8PDB	0x80D4
+#define PCI_DEVICE_ID_EQNX_SST4PPWR	0x88EC
+#define PCI_DEVICE_ID_EQNX_SST8PHP	0x90F0
+#define PCI_DEVICE_ID_EQNX_SST8PPWR	0x90F4
+#define PCI_DEVICE_ID_EQNX_SST4PULP	0x88FC
 
 
 #define PCI_VENDOR_ID_SYSKONNECT	0x1148
