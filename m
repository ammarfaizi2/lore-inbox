Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965513AbWJaLKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965513AbWJaLKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 06:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965505AbWJaLKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 06:10:40 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:21257 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S965467AbWJaLKj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 06:10:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch 2/2] SCSI: Add nvidia SATA controllers of MCP67 support to sata_nv.c
Date: Tue, 31 Oct 2006 19:10:17 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C42D7F8@hkemmail01.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch 2/2] SCSI: Add nvidia SATA controllers of MCP67 support to sata_nv.c
Thread-Index: Acb8wDUe6bzb7vNjT5eAtbRlXAhmbAAAkpmQAAaboZA=
From: "Peer Chen" <pchen@nvidia.com>
To: "Peer Chen" <pchen@nvidia.com>, <jgarzik@pobox.com>,
       <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Oct 2006 11:10:24.0408 (UTC) FILETIME=[29B11180:01C6FCDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peer Chen <pchen@nvidia.com>

=============================

--- linux-2.6.18/include/linux/pci_ids.h.orig	2006-10-31
15:47:12.000000000 +0800
+++ linux-2.6.18/include/linux/pci_ids.h	2006-10-31
18:22:51.000000000 +0800
@@ -1211,6 +1211,15 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_21              0x0451
 #define PCI_DEVICE_ID_NVIDIA_NVENET_22              0x0452
 #define PCI_DEVICE_ID_NVIDIA_NVENET_23              0x0453
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA      0x045C
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA2     0x045D
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA3     0x045E
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SATA4     0x045F
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA      0x0550
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA2     0x0551
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA3     0x0552
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SATA4     0x0553
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE       0x0560
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
