Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTKAPn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 10:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbTKAPn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 10:43:56 -0500
Received: from qfep04.superonline.com ([212.252.122.160]:15867 "EHLO
	qfep04.superonline.com") by vger.kernel.org with ESMTP
	id S263861AbTKAPny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 10:43:54 -0500
Message-ID: <3FA3D45E.3030602@superonline.com>
Date: Sat, 01 Nov 2003 17:42:22 +0200
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: missing nforce3s pci-id in current -bk
Content-Type: multipart/mixed;
 boundary="------------020005090706030700090300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020005090706030700090300
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

Cset 1.1173.1.3 -> 1.1173.1.4 (ak@muc.de, K8 AGP driver updates)
misses patching pci_ids.h for nforce3s. Attached.

Özkan Sezer


--------------020005090706030700090300
Content-Type: text/plain;
 name="nforce3s-pci_ids.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nforce3s-pci_ids.patch"

diff -ru linux/include/linux/pci_ids.h	linux-nforce3s/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h	2003-08-25 04:44:44.000000000 -0700
+++ linux-nforce3s/include/linux/pci_ids.h	2003-09-29 18:29:11.000000000 -0700
@@ -966,6 +966,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE	0x0065
 #define PCI_DEVICE_ID_NVIDIA_ITNT2		0x00A0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE3		0x00d1
+#define PCI_DEVICE_ID_NVIDIA_NFORCE3S		0x00e1
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_SDR	0x0100
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_DDR	0x0101
 #define PCI_DEVICE_ID_NVIDIA_QUADRO		0x0103

--------------020005090706030700090300--

