Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbWBHDVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbWBHDVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWBHDUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:20:53 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:6273 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030477AbWBHDUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:20:07 -0500
To: torvalds@osdl.org
Subject: [PATCH 27/29] arch/x86_64/pci/mmconfig.c NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fsF-0006Eo-6Q@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:20:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1139016481 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/x86_64/pci/mmconfig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

cc59853b4a9973126e15e0e6bdddf0627d4b99c4
diff --git a/arch/x86_64/pci/mmconfig.c b/arch/x86_64/pci/mmconfig.c
index b4a3fe4..18f371f 100644
--- a/arch/x86_64/pci/mmconfig.c
+++ b/arch/x86_64/pci/mmconfig.c
@@ -49,7 +49,7 @@ static char __iomem *get_virt(unsigned i
 		return pci_mmcfg_virt[0].virt;
 
 	/* Fall back to type 0 */
-	return 0;
+	return NULL;
 }
 
 static char __iomem *pci_dev_base(unsigned int seg, unsigned int bus, unsigned int devfn)
-- 
0.99.9.GIT

