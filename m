Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbSI2ODM>; Sun, 29 Sep 2002 10:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262483AbSI2ODM>; Sun, 29 Sep 2002 10:03:12 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:32785 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S262482AbSI2ODL>;
	Sun, 29 Sep 2002 10:03:11 -0400
Date: Sun, 29 Sep 2002 16:08:31 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.5.39 - i8xx series chipsets patches (patch2)
Message-ID: <20020929160831.A7361@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

this patch adds a number of defines for the the 82801E and 82801DB I/O Controller Hubs to the pci_ids.h file.

Greetings,
Wim.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.635   -> 1.636  
#	include/linux/pci_ids.h	1.59    -> 1.60   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/29	wim@iguana.be	1.636
# [PATCH] 2.5.39 - i8xx series chipsets patches (patch 2)
# 
# Add defines to pci_ids.h for 82801E and 82801DB I/O Controller Hub PCI-IDS.
# --------------------------------------------
#
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Sun Sep 29 15:20:51 2002
+++ b/include/linux/pci_ids.h	Sun Sep 29 15:20:52 2002
@@ -1713,8 +1713,13 @@
 #define PCI_DEVICE_ID_INTEL_82801BA_9	0x244b
 #define PCI_DEVICE_ID_INTEL_82801BA_10	0x244c
 #define PCI_DEVICE_ID_INTEL_82801BA_11	0x244e
+#define PCI_DEVICE_ID_INTEL_82801E_0	0x2450
+#define PCI_DEVICE_ID_INTEL_82801E_2	0x2452
+#define PCI_DEVICE_ID_INTEL_82801E_3	0x2453
 #define PCI_DEVICE_ID_INTEL_82801E_9	0x245b
 #define PCI_DEVICE_ID_INTEL_82801E_11	PCI_DEVICE_ID_INTEL_82801E_9
+#define PCI_DEVICE_ID_INTEL_82801E_13	0x245d
+#define PCI_DEVICE_ID_INTEL_82801E_14	0x245e
 #define PCI_DEVICE_ID_INTEL_82801CA_0	0x2480
 #define PCI_DEVICE_ID_INTEL_82801CA_2	0x2482
 #define PCI_DEVICE_ID_INTEL_82801CA_3	0x2483
@@ -1725,8 +1730,16 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_10	0x248a
 #define PCI_DEVICE_ID_INTEL_82801CA_11	0x248b
 #define PCI_DEVICE_ID_INTEL_82801CA_12	0x248c
+#define PCI_DEVICE_ID_INTEL_82801DB_0	0x24c0
+#define PCI_DEVICE_ID_INTEL_82801DB_2	0x24c2
+#define PCI_DEVICE_ID_INTEL_82801DB_3	0x24c3
+#define PCI_DEVICE_ID_INTEL_82801DB_4	0x24c4
+#define PCI_DEVICE_ID_INTEL_82801DB_5	0x24c5
+#define PCI_DEVICE_ID_INTEL_82801DB_6	0x24c6
+#define PCI_DEVICE_ID_INTEL_82801DB_7	0x24c7
 #define PCI_DEVICE_ID_INTEL_82801DB_9	0x24cb
 #define PCI_DEVICE_ID_INTEL_82801DB_11	PCI_DEVICE_ID_INTEL_82801DB_9
+#define PCI_DEVICE_ID_INTEL_82801DB_13	0x24cd
 #define PCI_DEVICE_ID_INTEL_82820_HB	0x2500
 #define PCI_DEVICE_ID_INTEL_82820_UP_HB	0x2501
 #define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
