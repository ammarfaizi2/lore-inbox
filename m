Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVDAXzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVDAXzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVDAXtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:49:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:25820 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262808AbVDAXsJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:09 -0500
Cc: roland@topspin.com
Subject: [PATCH] PCI: Add PCI device ID for new Mellanox HCA
In-Reply-To: <11123992692790@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:50 -0800
Message-Id: <11123992704154@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.5, 2005/03/17 10:11:55-08:00, roland@topspin.com

[PATCH] PCI: Add PCI device ID for new Mellanox HCA

Add PCI device IDs for new Mellanox "Sinai" InfiniHost III Lx HCA.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/pci_ids.h |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-04-01 15:38:14 -08:00
+++ b/include/linux/pci_ids.h	2005-04-01 15:38:14 -08:00
@@ -2115,6 +2115,8 @@
 #define PCI_DEVICE_ID_MELLANOX_TAVOR	0x5a44
 #define PCI_DEVICE_ID_MELLANOX_ARBEL_COMPAT 0x6278
 #define PCI_DEVICE_ID_MELLANOX_ARBEL	0x6282
+#define PCI_DEVICE_ID_MELLANOX_SINAI_OLD 0x5e8c
+#define PCI_DEVICE_ID_MELLANOX_SINAI	0x6274
 
 #define PCI_VENDOR_ID_PDC		0x15e9
 #define PCI_DEVICE_ID_PDC_1841		0x1841

