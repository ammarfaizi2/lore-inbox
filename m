Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262916AbVDAWOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262916AbVDAWOS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVDAWLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:11:03 -0500
Received: from webmail.topspin.com ([12.162.17.3]:31086 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262916AbVDAWHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:07:11 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, greg@kroah.com
Subject: [PATCH][26.5/27] Add MT25204 PCI IDs
X-Message-Flag: Warning: May contain useful information
References: <2005411249.RHQWyM8AFcqb1PM4@topspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 01 Apr 2005 14:06:50 -0800
In-Reply-To: <2005411249.RHQWyM8AFcqb1PM4@topspin.com> (Roland Dreier's
 message of "Fri, 1 Apr 2005 12:49:54 -0800")
Message-ID: <52hdiqi22t.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Apr 2005 22:06:50.0605 (UTC) FILETIME=[1AEE49D0:01C53707]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh, this patch is required to build support for the new Mellanox
HCAs.  Greg K-H applied it to his tree a while ago but it hasn't made
it to Linus yet.

Sorry,
  Roland

Add PCI device IDs for new Mellanox MT25204 "Sinai" InfiniHost III Lx HCA.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-export.orig/include/linux/pci_ids.h	2005-03-31 19:07:14.000000000 -0800
+++ linux-export/include/linux/pci_ids.h	2005-04-01 14:03:16.468519075 -0800
@@ -2122,6 +2122,8 @@
 #define PCI_DEVICE_ID_MELLANOX_TAVOR	0x5a44
 #define PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT 0x6278
 #define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
+#define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
+#define PCI_DEVICE_ID_MELLANOX_SINAI	0x6274
 
 #define PCI_VENDOR_ID_PDC		0x15e9
 #define PCI_DEVICE_ID_PDC_1841		0x1841

