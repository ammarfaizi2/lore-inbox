Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUCVKAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 05:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUCVKAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 05:00:22 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:18753 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S261851AbUCVKAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 05:00:18 -0500
Date: Mon, 22 Mar 2004 11:00:15 +0100
Message-Id: <200403221000.i2MA0FVi004115@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 144] Mac baboon warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac baboon: Kill warning

--- linux-2.4.26-pre5/arch/m68k/mac/baboon.c	2003-04-06 10:28:29.000000000 +0200
+++ linux-m68k-2.4.26-pre5/arch/m68k/mac/baboon.c	2003-11-30 13:19:31.000000000 +0100
@@ -19,8 +19,8 @@
 #include <asm/macints.h> 
 #include <asm/mac_baboon.h>
 
-/* #define DEBUG_BABOON /**/
-/* #define DEBUG_IRQS /**/
+/* #define DEBUG_BABOON */
+/* #define DEBUG_IRQS */
 
 int baboon_present,baboon_active;
 volatile struct baboon *baboon;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
