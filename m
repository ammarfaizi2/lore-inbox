Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVCAFur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVCAFur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 00:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVCAFur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 00:50:47 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:9974 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261246AbVCAFul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 00:50:41 -0500
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH] Add PCI device ID for new Mellanox HCA
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Mon, 28 Feb 2005 21:50:38 -0800
Message-ID: <52fyzfrk29.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Mar 2005 05:50:39.0065 (UTC) FILETIME=[98C44C90:01C51E22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's a device ID for the new HCA that Mellanox just introduced.
Please queue this up for 2.6.12.

Thanks,
  Roland


Add PCI device ID for new Mellanox "Sinai" InfiniHost III Lx HCA.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-svn.orig/include/linux/pci_ids.h	2005-02-28 21:08:38.592176783 -0800
+++ linux-svn/include/linux/pci_ids.h	2005-02-28 21:10:37.198431351 -0800
@@ -1992,6 +1992,7 @@
 #define PCI_DEVICE_ID_MELLANOX_TAVOR	0x5a44
 #define PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT 0x6278
 #define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
+#define PCI_DEVICE_ID_MELLANOX_SINAI	0x5e8c
 
 #define PCI_VENDOR_ID_PDC		0x15e9
 #define PCI_DEVICE_ID_PDC_1841		0x1841
