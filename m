Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVDES4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVDES4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVDESzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:55:12 -0400
Received: from ns3.dataphone.se ([212.37.0.170]:4308 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261514AbVDESvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:51:17 -0400
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050405181944.16123.2372.92859@clementine.local>
Subject: [PATCH] opl3sa2: MODULE_PARM_DESC
Date: Tue,  5 Apr 2005 20:51:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

opl3sa2: Fix "irq"-parameter name typo for parameter description.

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.12-rc2/sound/oss/opl3sa2.c	2005-04-05 16:57:30.000000000 +0200
+++ linux-2.6.12-rc2-autoparam/sound/oss/opl3sa2.c	2005-04-05 19:22:49.469074368 +0200
@@ -199,7 +199,7 @@
 MODULE_PARM_DESC(mpu_io, "Set MIDI I/O base (0x330 or other. Address must be even and must be from 0x300 to 0x334)");
 
 module_param(irq, int, 0);
-MODULE_PARM_DESC(mss_irq, "Set MSS (audio) IRQ (5, 7, 9, 10, 11, 12)");
+MODULE_PARM_DESC(irq, "Set MSS (audio) IRQ (5, 7, 9, 10, 11, 12)");
 
 module_param(dma, int, 0);
 MODULE_PARM_DESC(dma, "Set MSS (audio) first DMA channel (0, 1, 3)");
