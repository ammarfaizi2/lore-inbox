Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVCAQoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVCAQoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 11:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVCAQoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 11:44:00 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:60745 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261967AbVCAQn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 11:43:58 -0500
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH] Add PCI device ID for new Mellanox HCA
X-Message-Flag: Warning: May contain useful information
References: <52fyzfrk29.fsf@topspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 01 Mar 2005 08:42:47 -0800
In-Reply-To: <52fyzfrk29.fsf@topspin.com> (Roland Dreier's message of "Mon,
 28 Feb 2005 21:50:38 -0800")
Message-ID: <52oee3pbaw.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Mar 2005 16:42:47.0253 (UTC) FILETIME=[B2FBF850:01C51E7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

It turns out that Mellanox decided to change the device ID at the last
minute.  So of course there will be parts with both IDs.  Here's an
updated patch that includes both IDs.  Please use this instead.
 
Thanks,
  Roland



Add PCI device IDs for new Mellanox "Sinai" InfiniHost III Lx HCA.

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-svn.orig/include/linux/pci_ids.h	2005-02-28 21:10:53.000000000 -0800
+++ linux-svn/include/linux/pci_ids.h	2005-03-01 08:39:49.766178558 -0800
@@ -1992,6 +1992,8 @@
 #define PCI_DEVICE_ID_MELLANOX_TAVOR	0x5a44
 #define PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT 0x6278
 #define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
+#define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
+#define PCI_DEVICE_ID_MELLANOX_SINAI	0x6274
 
 #define PCI_VENDOR_ID_PDC		0x15e9
 #define PCI_DEVICE_ID_PDC_1841		0x1841
