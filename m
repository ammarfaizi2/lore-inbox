Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263081AbSJIXQO>; Wed, 9 Oct 2002 19:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSJIXPa>; Wed, 9 Oct 2002 19:15:30 -0400
Received: from dp.samba.org ([66.70.73.150]:22185 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262937AbSJIXOx>;
	Wed, 9 Oct 2002 19:14:53 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15780.47247.488995.431857@nanango.paulus.ozlabs.org>
Date: Thu, 10 Oct 2002 09:15:27 +1000 (EST)
To: torvalds@transmeta.com
Cc: mj@ucw.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] add PCI device ID for Motorola MPC107
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch adds the PCI device ID for the Motorola MPC107 host bridge.
The entry is already in the list at pciids.sf.net but isn't in the
kernel pci_ids.h file yet.  Please apply this to your tree.

Thanks,
Paul.

diff -urN linux-2.5/include/linux/pci_ids.h linuxppc-2.5/include/linux/pci_ids.h
--- linux-2.5/include/linux/pci_ids.h	2002-10-07 11:21:18.000000000 +1000
+++ linuxppc-2.5/include/linux/pci_ids.h	2002-10-07 12:27:41.000000000 +1000
@@ -623,6 +623,7 @@
 #define PCI_VENDOR_ID_MOTOROLA_OOPS	0x1507
 #define PCI_DEVICE_ID_MOTOROLA_MPC105	0x0001
 #define PCI_DEVICE_ID_MOTOROLA_MPC106	0x0002
+#define PCI_DEVICE_ID_MOTOROLA_MPC107	0x0004
 #define PCI_DEVICE_ID_MOTOROLA_RAVEN	0x4801
 #define PCI_DEVICE_ID_MOTOROLA_FALCON	0x4802
 #define PCI_DEVICE_ID_MOTOROLA_HAWK	0x4803
