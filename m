Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUK3Q6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUK3Q6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbUK3Q5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:57:20 -0500
Received: from linaeum.absolutedigital.net ([63.87.232.45]:24210 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S262192AbUK3Qzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:55:43 -0500
Date: Tue, 30 Nov 2004 11:55:41 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] remove obsolete PIIX config help
Message-ID: <Pine.LNX.4.61.0411301129290.31814@linaeum.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

The patch below removes some obsolete config help for the Intel PIIX 
chipsets.

-- Cal

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- linux-2.4.29-pre1/Documentation/Configure.help	2004-11-30 11:17:08.000000000 -0500
+++ linux-2.4.29-pre1-1/Documentation/Configure.help	2004-11-30 11:18:23.000000000 -0500
@@ -1317,21 +1317,6 @@
 
   Please read the comments at the top of <file:drivers/ide/pci/piix.c>.
 
-  If you say Y here, you should also say Y to "PIIXn Tuning support",
-  below.
-
-  If unsure, say N.
-
-PIIXn Tuning support
-CONFIG_PIIX_TUNING
-  This driver extension adds DMA mode setting and tuning for all PIIX
-  IDE controllers by Intel. Since the BIOS can sometimes improperly
-  set up the device/adapter combination and speed limits, it has
-  become a necessity to back/forward speed devices as needed.
-
-  Case 430HX/440FX PIIX3 need speed limits to reduce UDMA to DMA mode
-  2 if the BIOS can not perform this task at initialization.
-
   If unsure, say N.
 
 Promise PDC202{46|62|65|67} support
