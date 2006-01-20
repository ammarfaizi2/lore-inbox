Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWATTFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWATTFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWATTF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:35280 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751175AbWATTFF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:05 -0500
Cc: MRustad@mac.com
Subject: [PATCH] PCI: restore 2 missing pci ids
In-Reply-To: <11377838781658@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:38 -0800
Message-Id: <11377838782630@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: restore 2 missing pci ids

Somewhere between 2.6.14 and 2.6.15-rc3, some PCI ids were apparently
removed.  The ecc.c module, which is not a part of the kernel.org tree, but
included in some distributions, fails to compile.

Signed-off-by: Mark Rustad <mrustad@mac.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9b88de850747ab8ff39ce31ca6ff788210f9441a
tree a9ba9136f00c3434c6adf741b9b3f9308af42d73
parent d181278c96e0b59478bef909ec2476c40169e7ba
author Mark Rustad <MRustad@mac.com> Thu, 05 Jan 2006 22:47:29 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:34 -0800

 include/linux/pci_ids.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 117e023..560b26a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2065,6 +2065,7 @@
 #define PCI_DEVICE_ID_INTEL_82801EB_5	0x24d5
 #define PCI_DEVICE_ID_INTEL_82801EB_6	0x24d6
 #define PCI_DEVICE_ID_INTEL_82801EB_11	0x24db
+#define PCI_DEVICE_ID_INTEL_82801EB_13	0x24dd
 #define PCI_DEVICE_ID_INTEL_ESB_1	0x25a1
 #define PCI_DEVICE_ID_INTEL_ESB_2	0x25a2
 #define PCI_DEVICE_ID_INTEL_ESB_4	0x25a4
@@ -2154,6 +2155,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_2	0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1	0x7601
 #define PCI_DEVICE_ID_INTEL_82454GX	0x84c4
+#define PCI_DEVICE_ID_INTEL_82450GX	0x84c5
 #define PCI_DEVICE_ID_INTEL_82451NX	0x84ca
 #define PCI_DEVICE_ID_INTEL_82454NX     0x84cb
 #define PCI_DEVICE_ID_INTEL_84460GX	0x84ea

