Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422926AbWJaIGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWJaIGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWJaIGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:06:24 -0500
Received: from hqemgate02.nvidia.com ([216.228.112.143]:24 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1422809AbWJaIGW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:06:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [Patch 2/2] SCSI: Add nvidia SATA controllers of MCP67 support to sata_nv.c
Date: Tue, 31 Oct 2006 16:01:09 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B0C42D598@hkemmail01.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch 2/2] SCSI: Add nvidia SATA controllers of MCP67 support to sata_nv.c
Thread-Index: Acb8wDUe6bzb7vNjT5eAtbRlXAhmbAAAkpmQ
From: "Peer Chen" <pchen@nvidia.com>
To: <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Oct 2006 08:01:10.0936 (UTC) FILETIME=[BA7EB980:01C6FCC2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the IDs of SATA controllers of MCP67 & MCP65 to pci_ids.h file.
The following pci_ids.h patch is based on kernel 2.6.18.

Signed-off by: Peer Chen <pchen@nvidia.com>
===================================

--- pci_ids.h.orig	2006-10-30 14:13:08.000000000 +0800
+++ pci_ids.h	2006-10-31 13:51:32.000000000 +0800
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
