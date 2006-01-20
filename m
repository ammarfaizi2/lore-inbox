Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWATTHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWATTHd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWATTFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:05:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:32464 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751161AbWATTFB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:05:01 -0500
Cc: gcoady@gmail.com
Subject: [PATCH] PCI: pci_ids: remove duplicates gathered during merge period
In-Reply-To: <1137783878475@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Jan 2006 11:04:38 -0800
Message-Id: <11377838789@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: pci_ids: remove duplicates gathered during merge period

pci_ids.h: remove duplicates.  Compile tested allmodconfig.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6404e7c38021e2e9bed564ee3ede2afe43611c3b
tree 44e17a37e7d0648a39d9a7319d1f563ed1a1b2e5
parent 9b88de850747ab8ff39ce31ca6ff788210f9441a
author Grant Coady <gcoady@gmail.com> Sun, 15 Jan 2006 16:21:27 +1100
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 20 Jan 2006 10:29:34 -0800

 include/linux/pci_ids.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 560b26a..ab8593a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -394,14 +394,9 @@
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
@@ -511,8 +506,6 @@
 #define PCI_DEVICE_ID_AMD_CS5536_UOC    0x2097
 #define PCI_DEVICE_ID_AMD_CS5536_IDE    0x209A
 
-#define PCI_DEVICE_ID_AMD_CS5536_IDE	0x209A
-
 #define PCI_DEVICE_ID_AMD_LX_VIDEO  0x2081
 #define PCI_DEVICE_ID_AMD_LX_AES    0x2082
 

