Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUCDXmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 18:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbUCDXmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 18:42:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:57032 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261975AbUCDXmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 18:42:04 -0500
Subject: [PATCH] Fix typo in radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078443709.5703.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 10:41:49 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This fix a typo in the list of PCI IDs in radeonfb, fixing
detection of some mobility models.

Ben.

===== drivers/video/aty/radeon_base.c 1.11 vs edited =====
--- 1.11/drivers/video/aty/radeon_base.c	Thu Mar  4 11:13:58 2004
+++ edited/drivers/video/aty/radeon_base.c	Fri Mar  5 10:40:50 2004
@@ -135,7 +135,7 @@
 	CHIP_DEF(PCI_CHIP_R200_QM,	R200,	CHIP_HAS_CRTC2),
 	/* Mobility M7 */
 	CHIP_DEF(PCI_CHIP_RADEON_LW,	RV200,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
-	CHIP_DEF(PCI_CHIP_RADEON_LW,	RV200,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
+	CHIP_DEF(PCI_CHIP_RADEON_LX,	RV200,	CHIP_HAS_CRTC2 | CHIP_IS_MOBILITY),
 	/* 7500 */
 	CHIP_DEF(PCI_CHIP_RV200_QW,	RV200,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV200_QX,	RV200,	CHIP_HAS_CRTC2),


