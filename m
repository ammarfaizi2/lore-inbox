Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129150AbQKVPqW>; Wed, 22 Nov 2000 10:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129208AbQKVPqM>; Wed, 22 Nov 2000 10:46:12 -0500
Received: from [195.63.194.11] ([195.63.194.11]:63496 "EHLO
        mail.stock-world.de") by vger.kernel.org with ESMTP
        id <S129150AbQKVPqI>; Wed, 22 Nov 2000 10:46:08 -0500
Message-ID: <3A1BEF7A.CA92A277@evision-ventures.com>
Date: Wed, 22 Nov 2000 17:08:26 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI id list update
Content-Type: multipart/mixed;
 boundary="------------37B84895815E47AC7E058442"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------37B84895815E47AC7E058442
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Just a small trivial obviously correct update...
--------------37B84895815E47AC7E058442
Content-Type: text/plain; charset=us-ascii;
 name="pci-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-update.patch"

diff -ur linux/include/linux/pci_ids.h linux-mega/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h	Tue Nov 21 16:31:52 2000
+++ linux-mega/include/linux/pci_ids.h	Tue Nov 21 18:54:58 2000
@@ -257,6 +257,11 @@
 #define PCI_VENDOR_ID_WD		0x101c
 #define PCI_DEVICE_ID_WD_7197		0x3296
 
+#define PCI_VENDOR_ID_AMI		0x101E
+#define PCI_DEVICE_ID_AMI_MEGARAID	0x9010
+#define PCI_DEVICE_ID_AMI_MEGARAID2	0x9060
+#define PCI_DEVICE_ID_AMI_MEGARAID3	0x1960
+
 #define PCI_VENDOR_ID_AMD		0x1022
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
@@ -365,8 +370,8 @@
 #define PCI_DEVICE_ID_PCTECH_SAMURAI_1	0x3010
 #define PCI_DEVICE_ID_PCTECH_SAMURAI_IDE 0x3020
 
-#define PCI_VENDOR_ID_DPT               0x1044   
-#define PCI_DEVICE_ID_DPT               0xa400  
+#define PCI_VENDOR_ID_DPT               0x1044
+#define PCI_DEVICE_ID_DPT               0xa400
 
 #define PCI_VENDOR_ID_OPTI		0x1045
 #define PCI_DEVICE_ID_OPTI_92C178	0xc178
@@ -1210,6 +1215,7 @@
 #define PCI_DEVICE_ID_INTEL_82441	0x1237
 #define PCI_DEVICE_ID_INTEL_82380FB	0x124b
 #define PCI_DEVICE_ID_INTEL_82439	0x1250
+#define PCI_DEVICE_ID_INTEL_80960_RP	0x1960
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
 #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020

--------------37B84895815E47AC7E058442--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
