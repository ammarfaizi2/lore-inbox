Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263633AbUESE53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbUESE53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 00:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUESE52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 00:57:28 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:33320 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263633AbUESE51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 00:57:27 -0400
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       tziporet@mellanox.co.il
Subject: [PATCH] Add InfiniBand HCA IDs to pci_ids.h
References: <52r7tjug7y.fsf@topspin.com> <20040518154604.GA3033@infradead.org>
	<52d651nvvd.fsf@topspin.com> <20040518235403.GB11042@kroah.com>
	<52ad05mcu2.fsf@topspin.com> <20040519033119.GB7196@kroah.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 18 May 2004 21:57:26 -0700
In-Reply-To: <20040519033119.GB7196@kroah.com>
Message-ID: <52fz9xko95.fsf_-_@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 May 2004 04:57:26.0142 (UTC) FILETIME=[C77E69E0:01C43D5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add InfiniBand HCA IDs to pci_ids.h.
This will let me kill mthca_pci.h in the mthca driver.

Thanks,
  Roland

===== include/linux/pci_ids.h 1.157 vs edited =====
--- 1.157/include/linux/pci_ids.h	Mon May 17 16:37:38 2004
+++ edited/include/linux/pci_ids.h	Tue May 18 21:50:17 2004
@@ -1865,6 +1865,11 @@
 #define PCI_VENDOR_ID_ZOLTRIX		0x15b0
 #define PCI_DEVICE_ID_ZOLTRIX_2BD0	0x2bd0 
 
+#define PCI_VENDOR_ID_MELLANOX		0x15b3
+#define PCI_DEVICE_ID_MELLANOX_TAVOR	0x5a44
+#define PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT 0x6278
+#define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
+
 #define PCI_VENDOR_ID_PDC		0x15e9
 #define PCI_DEVICE_ID_PDC_1841		0x1841
 
@@ -1885,6 +1890,8 @@
 #define PCI_VENDOR_ID_S2IO		0x17d5
 #define	PCI_DEVICE_ID_S2IO_WIN		0x5731
 #define	PCI_DEVICE_ID_S2IO_UNI		0x5831
+
+#define PCI_VENDOR_ID_TOPSPIN		0x1867
 
 #define PCI_VENDOR_ID_ARC               0x192E
 #define PCI_DEVICE_ID_ARC_EHCI          0x0101
