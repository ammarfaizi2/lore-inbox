Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVDLLK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVDLLK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVDLLKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:10:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:24266 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262250AbVDLKdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:06 -0400
Message-Id: <200504121032.j3CAWskb005713@shell0.pdx.osdl.net>
Subject: [patch 142/198] opl3sa2: MODULE_PARM_DESC
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, damm@opensource.se
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:48 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Magnus Damm <damm@opensource.se>

opl3sa2: Fix "irq"-parameter name typo for parameter description.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/sound/oss/opl3sa2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN sound/oss/opl3sa2.c~opl3sa2-module_parm_desc sound/oss/opl3sa2.c
--- 25/sound/oss/opl3sa2.c~opl3sa2-module_parm_desc	2005-04-12 03:21:37.571425176 -0700
+++ 25-akpm/sound/oss/opl3sa2.c	2005-04-12 03:21:37.575424568 -0700
@@ -199,7 +199,7 @@ module_param(mpu_io, int, 0);
 MODULE_PARM_DESC(mpu_io, "Set MIDI I/O base (0x330 or other. Address must be even and must be from 0x300 to 0x334)");
 
 module_param(irq, int, 0);
-MODULE_PARM_DESC(mss_irq, "Set MSS (audio) IRQ (5, 7, 9, 10, 11, 12)");
+MODULE_PARM_DESC(irq, "Set MSS (audio) IRQ (5, 7, 9, 10, 11, 12)");
 
 module_param(dma, int, 0);
 MODULE_PARM_DESC(dma, "Set MSS (audio) first DMA channel (0, 1, 3)");
_
