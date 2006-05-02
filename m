Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWEBUbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWEBUbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWEBUbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:31:15 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:54225 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751274AbWEBUbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:31:15 -0400
Message-ID: <4457C185.1070402@myri.com>
Date: Tue, 02 May 2006 22:31:01 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add PCI_CAP_ID_VNDR
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The following patch adds the vendor-specific extended capability PCI_CAP_ID_VNDR.
It will be used by the Myri-10G Ethernet driver (will be submitted soon).

Signed-off-by: Brice Goglin <brice@myri.com>

 pci_regs.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-mm/include/linux/pci_regs.h.old	2006-04-21 08:22:42.000000000 -0700
+++ linux-mm/include/linux/pci_regs.h	2006-04-21 08:28:56.000000000 -0700
@@ -197,6 +197,7 @@
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
 #define  PCI_CAP_ID_HT_IRQCONF	0x08	/* HyperTransport IRQ Configuration */
+#define  PCI_CAP_ID_VNDR	0x09	/* Vendor specific capability */
 #define  PCI_CAP_ID_SHPC 	0x0C	/* PCI Standard Hot-Plug Controller */
 #define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */
 #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */


