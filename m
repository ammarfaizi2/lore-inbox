Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbTCaABa>; Sun, 30 Mar 2003 19:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbTCaABa>; Sun, 30 Mar 2003 19:01:30 -0500
Received: from dp.samba.org ([66.70.73.150]:28037 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261341AbTCaAB3>;
	Sun, 30 Mar 2003 19:01:29 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16007.34460.490218.663220@nanango.paulus.ozlabs.org>
Date: Mon, 31 Mar 2003 10:06:52 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add some more Apple PCI ids
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds the PCI ids for some of the newer Apple chips.

Please apply.

Paul.

diff -urN linux-2.5/include/linux/pci_ids.h linuxppc-2.5/include/linux/pci_ids.h
--- linux-2.5/include/linux/pci_ids.h	2003-03-25 10:44:11.000000000 +1100
+++ linuxppc-2.5/include/linux/pci_ids.h	2003-03-25 13:17:24.000000000 +1100
@@ -758,6 +758,10 @@
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP_P	0x0027
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP15	0x002d
 #define PCI_DEVICE_ID_APPLE_UNI_N_FW2	0x0030
+#define PCI_DEVICE_ID_APPLE_UNI_N_GMAC2	0x0032
+#define PCI_DEVICE_ID_APPLE_UNI_N_AGP2	0x0034
+#define PCI_DEVICE_ID_APPLE_KEYLARGO_I	0x003e
+#define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073
 #define PCI_DEVICE_ID_YAMAHA_724	0x0004
