Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUE1Vn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUE1Vn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUE1Vlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:41:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:38323 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263995AbUE1ViH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:38:07 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <10857801111252@kroah.com>
Date: Fri, 28 May 2004 14:35:15 -0700
Message-Id: <10857801151567@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1717.6.24, 2004/05/18 23:57:17-07:00, roland@topspin.com

[PATCH] PCI: Add InfiniBand HCA IDs to pci_ids.h

Add InfiniBand HCA IDs to pci_ids.h.


 include/linux/pci_ids.h |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Fri May 28 14:29:20 2004
+++ b/include/linux/pci_ids.h	Fri May 28 14:29:20 2004
@@ -1870,6 +1870,11 @@
 #define PCI_VENDOR_ID_ZOLTRIX		0x15b0
 #define PCI_DEVICE_ID_ZOLTRIX_2BD0	0x2bd0 
 
+#define PCI_VENDOR_ID_MELLANOX		0x15b3
+#define PCI_DEVICE_ID_MELLANOX_TAVOR	0x5a44
+#define PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT 0x6278
+#define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
+
 #define PCI_VENDOR_ID_PDC		0x15e9
 #define PCI_DEVICE_ID_PDC_1841		0x1841
 
@@ -1890,6 +1895,8 @@
 #define PCI_VENDOR_ID_S2IO		0x17d5
 #define	PCI_DEVICE_ID_S2IO_WIN		0x5731
 #define	PCI_DEVICE_ID_S2IO_UNI		0x5831
+
+#define PCI_VENDOR_ID_TOPSPIN		0x1867
 
 #define PCI_VENDOR_ID_ARC               0x192E
 #define PCI_DEVICE_ID_ARC_EHCI          0x0101

