Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUGTSvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUGTSvu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 14:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUGTStH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 14:49:07 -0400
Received: from amsfep19-int.chello.nl ([213.46.243.20]:56146 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S266170AbUGTSom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 14:44:42 -0400
Date: Tue, 20 Jul 2004 20:38:08 +0200
Message-Id: <200407201838.i6KIc8gc015439@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 482] M68k checksum include
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing include, showing up due to include reshuffling in 2.6.8-rc1

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.8-rc2/arch/m68k/lib/checksum.c	2004-04-28 11:05:46.000000000 +0200
+++ linux-m68k-2.6.8-rc2/arch/m68k/lib/checksum.c	2004-07-15 14:10:58.000000000 +0200
@@ -32,6 +32,7 @@
  *		csum_partial_copy_from_user.
  */
 
+#include <linux/module.h>
 #include <net/checksum.h>
 
 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
