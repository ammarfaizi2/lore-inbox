Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbUA1I4s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 03:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265870AbUA1I4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 03:56:48 -0500
Received: from mo02.iij4u.or.jp ([210.130.0.19]:17632 "EHLO mo02.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S265869AbUA1I4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 03:56:47 -0500
Date: Wed, 28 Jan 2004 17:56:30 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: marcelo.tosatti@cyclades.com.br
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] Added PCI device ID for it8181fb
Message-Id: <20040128175630.04c17605.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch is required in order to compile it8181fb.
This patch adds PCI device ID for it8181fb.

Please apply this patch.

Yoichi

diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Wed Jan 28 17:46:58 2004
+++ b/drivers/pci/pci.ids	Wed Jan 28 17:46:58 2004
@@ -4511,6 +4511,7 @@
 	9132  Ethernet 100/10 MBit
 1283  Integrated Technology Express, Inc.
 	673a  IT8330G
+	8181  IT8181E/F LCD/VGA Controller
 	8330  IT8330G
 	8888  IT8888F PCI to ISA Bridge with SMB
 	8889  IT8889F PCI to ISA Bridge
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	Wed Jan 28 17:46:58 2004
+++ b/include/linux/pci_ids.h	Wed Jan 28 17:46:58 2004
@@ -1438,6 +1438,7 @@
 #define PCI_VENDOR_ID_ITE		0x1283
 #define PCI_DEVICE_ID_ITE_IT8172G	0x8172
 #define PCI_DEVICE_ID_ITE_IT8172G_AUDIO 0x0801
+#define PCI_DEVICE_ID_ITE_IT8181	0x8181
 #define PCI_DEVICE_ID_ITE_8872		0x8872
 
 #define PCI_DEVICE_ID_ITE_IT8330G_0    0xe886
