Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbUKZXQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUKZXQX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbUKZTsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:48:20 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262395AbUKZT2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:55 -0500
Date: Thu, 25 Nov 2004 22:36:22 +0100
From: Domen Puncer <domen@coderock.org>
To: Alex Kern <alex.kern@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] video: semicolon bug in atyfb_base.c
Message-ID: <20041125213622.GA7889@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indentiation and logic suggest this was wrong.

Signed-off-by: Domen Puncer <domen@coderock.org>

--- c/drivers/video/aty/atyfb_base.c	2004-11-15 13:42:18.000000000 +0100
+++ str2/drivers/video/aty/atyfb_base.c	2004-11-25 21:14:52.000000000 +0100
@@ -440,11 +440,11 @@ static int __devinit correct_chipset(str
 	switch(par->pci_id) {
 #ifdef CONFIG_FB_ATY_GX
 	case PCI_CHIP_MACH64GX:
-		if(type != 0x00d7);
+		if(type != 0x00d7)
 			return -ENODEV;
 		break;
 	case PCI_CHIP_MACH64CX:
-		if(type != 0x0057);
+		if(type != 0x0057)
 			return -ENODEV;
 		break;
 #endif
