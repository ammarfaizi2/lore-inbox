Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317427AbSFHTQC>; Sat, 8 Jun 2002 15:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSFHTQB>; Sat, 8 Jun 2002 15:16:01 -0400
Received: from newman.msbb.uc.edu ([129.137.2.198]:57861 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S317427AbSFHTQB>;
	Sat, 8 Jun 2002 15:16:01 -0400
From: kuebelr@email.uc.edu
Date: Sat, 8 Jun 2002 15:15:48 -0400
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] remove agpgart_be.c unused variables
Message-Id: <20020608191548.GA21529@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a few un-needed variables in agpgart_be.c.  Patch is
against 2.4.19-pre10.

--- linux-clean/drivers/char/agp/agpgart_be.c	Fri Jun  7 23:41:55 2002
+++ linux-dirty/drivers/char/agp/agpgart_be.c	Sat Jun  8 00:45:17 2002
@@ -397,7 +397,7 @@
 static void agp_generic_agp_enable(u32 mode)
 {
 	struct pci_dev *device = NULL;
-	u32 command, scratch, cap_id;
+	u32 command, scratch;
 	u8 cap_ptr;
 
 	pci_read_config_dword(agp_bridge.dev,
@@ -4201,7 +4201,6 @@
 {
 	struct pci_dev *dev = NULL;
 	u8 cap_ptr = 0x00;
-	u32 cap_id, scratch;
 
 	if ((dev = pci_find_class(PCI_CLASS_BRIDGE_HOST << 8, NULL)) == NULL)
 		return -ENODEV;
