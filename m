Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbTLGVGY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 16:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbTLGVCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 16:02:34 -0500
Received: from amsfep13-int.chello.nl ([213.46.243.24]:57183 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S264558AbTLGVAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 16:00:44 -0500
Date: Sun, 7 Dec 2003 21:51:34 +0100
Message-Id: <200312072051.hB7KpY9P000795@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 144] Mac baboon warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac baboon: Kill warning

--- linux-2.4.23/arch/m68k/mac/baboon.c	2003-04-06 10:28:29.000000000 +0200
+++ linux-m68k-2.4.23/arch/m68k/mac/baboon.c	2003-11-30 13:19:31.000000000 +0100
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
