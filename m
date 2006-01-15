Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWAOFWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWAOFWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 00:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWAOFWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 00:22:36 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:27372 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751316AbWAOFWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 00:22:35 -0500
From: Grant Coady <gcoady@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pci_ids: remove duplicates gathered during merge period
Date: Sun, 15 Jan 2006 16:21:27 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <7qmjs1pg0terg55gjicjiejsf490tkpk23@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Grant Coady <gcoady@gmail.com>

pci_ids.h: remove duplicates.  Compile tested allmodconfig.

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 pci_ids.h |    7 -------
 1 files changed, 7 deletions(-)

--- linux-2.6.15-git10a/include/linux/pci_ids.h	2006-01-15 09:01:39.000000000 +1100
+++ linux-2.6.15-git10b/include/linux/pci_ids.h	2006-01-15 11:30:56.000000000 +1100
@@ -393,14 +393,9 @@
 #define PCI_DEVICE_ID_NS_SC1100_SMI	0x0511
 #define PCI_DEVICE_ID_NS_SC1100_XBUS	0x0515
 #define PCI_DEVICE_ID_NS_87410		0xd001
-#define PCI_DEVICE_ID_NS_CS5535_IDE	0x002d
 
 #define PCI_DEVICE_ID_NS_CS5535_HOST_BRIDGE  0x0028
 #define PCI_DEVICE_ID_NS_CS5535_ISA_BRIDGE   0x002b
-#define PCI_DEVICE_ID_NS_CS5535_IDE          0x002d
-#define PCI_DEVICE_ID_NS_CS5535_AUDIO        0x002e
-#define PCI_DEVICE_ID_NS_CS5535_USB          0x002f
-#define PCI_DEVICE_ID_NS_CS5535_VIDEO        0x0030
 
 #define PCI_VENDOR_ID_TSENG		0x100c
 #define PCI_DEVICE_ID_TSENG_W32P_2	0x3202
@@ -510,8 +505,6 @@
 #define PCI_DEVICE_ID_AMD_CS5536_UOC    0x2097
 #define PCI_DEVICE_ID_AMD_CS5536_IDE    0x209A
 
-#define PCI_DEVICE_ID_AMD_CS5536_IDE	0x209A
-
 #define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
 #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
 
