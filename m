Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUESPnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUESPnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUESPkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:40:40 -0400
Received: from gw0.infiniconsys.com ([65.219.193.226]:58351 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id S264260AbUESPkC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:40:02 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] Add InfiniCon PCI ID to pci_ids.h
Date: Wed, 19 May 2004 11:40:01 -0400
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB016973CC@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [openib-general] Re: [PATCH] Add InfiniBand HCA IDs to pci_ids.h
thread-index: AcQ9cC7jD6hyTfIuThas4thfSzSYnQAQ29Cg
From: "Rimmer, Todd" <trimmer@infiniconsys.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We would like to have the InfiniCon PCI Vendor ID added to pci_ids.h
Below is a context diff, which would would greatly appreciate if you
applied and included in future kernel releases.

===== include/linux/pci_ids.h 1.157 vs edited =====
--- 1.157/include/linux/pci_ids.h	Mon May 17 16:37:38 2004
+++ edited/include/linux/pci_ids.h	Tue May 18 21:50:17 2004
@@ -1885,6 +1890,8 @@
 #define PCI_VENDOR_ID_S2IO		0x17d5
 #define	PCI_DEVICE_ID_S2IO_WIN		0x5731
 #define	PCI_DEVICE_ID_S2IO_UNI		0x5831
+
+#define PCI_VENDOR_ID_INFINICON		0x1820
 
 #define PCI_VENDOR_ID_ARC               0x192E
 #define PCI_DEVICE_ID_ARC_EHCI          0x0101


Thank You,
Todd Rimmer
InfiniCon Systems
