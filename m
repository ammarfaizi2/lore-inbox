Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbTI1ULU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTI1ULU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:11:20 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:3683 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262712AbTI1ULT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:11:19 -0400
Date: Sun, 28 Sep 2003 14:55:40 +0200
Message-Id: <200309281255.h8SCteKK005666@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 333] Zorro include guards
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zorro: Make closing include guards consistent with opening include guards

--- linux-2.6.0-test6/include/asm-m68k/zorro.h	Tue Nov  5 10:10:14 2002
+++ linux-m68k-2.6.0-test6/include/asm-m68k/zorro.h	Sat Sep 27 16:34:10 2003
@@ -42,4 +42,4 @@
 #define z_iounmap iounmap
 #define z_ioremap z_remap_nocache_ser
 
-#endif /* _ASM_ZORRO_H */
+#endif /* _ASM_M68K_ZORRO_H */
--- linux-2.6.0-test6/include/asm-ppc/zorro.h	Mon Apr  1 13:03:12 2002
+++ linux-m68k-2.6.0-test6/include/asm-ppc/zorro.h	Sat Sep 27 16:34:33 2003
@@ -27,4 +27,4 @@
 #define z_ioremap ioremap
 #define z_iounmap iounmap
 
-#endif /* _ASM_ZORRO_H */
+#endif /* _ASM_PPC_ZORRO_H */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
