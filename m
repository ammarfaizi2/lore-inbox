Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267320AbUHIWZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267320AbUHIWZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267318AbUHIWXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:23:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36062 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267316AbUHIWWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:22:48 -0400
Date: Tue, 10 Aug 2004 00:22:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove bouncing address of Kip Walker
Message-ID: <20040809222238.GH26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless someone knows a non-bouncing email address of Kip Walker, I'd 
suggest the following patch to remove his bouncing address from 
sound/oss/swarm_cs4297a.c .


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc3-mm2-full/sound/oss/swarm_cs4297a.c.old	2004-08-10 00:12:13.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full/sound/oss/swarm_cs4297a.c	2004-08-10 00:13:35.000000000 +0200
@@ -10,7 +10,7 @@
 *               (audio@crystal.cirrus.com).
 *            -- adapted from cs4281 PCI driver for cs4297a on
 *               BCM1250 Synchronous Serial interface
-*               (kwalker@broadcom.com)
+*               (Kip Walker)
 *
 *      This program is free software; you can redistribute it and/or modify
 *      it under the terms of the GNU General Public License as published by
@@ -2732,7 +2732,7 @@
 
 EXPORT_NO_SYMBOLS;
 
-MODULE_AUTHOR("Kip Walker, kwalker@broadcom.com");
+MODULE_AUTHOR("Kip Walker");
 MODULE_DESCRIPTION("Cirrus Logic CS4297a Driver for Broadcom SWARM board");
 
 // --------------------------------------------------------------------- 

