Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbTLGUxy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbTLGUxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:53:53 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:13634 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264519AbTLGUxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:53:50 -0500
Date: Sun, 7 Dec 2003 21:49:36 +0100
Message-Id: <200312072049.hB7KnZrW000666@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 121] Zorro include guard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zorro: Make closing include guards consistent with opening include guards

--- linux-2.4.23/include/asm-m68k/zorro.h	Tue Nov  5 10:10:14 2002
+++ linux-m68k-2.4.23/include/asm-m68k/zorro.h	Sat Sep 27 16:34:10 2003
@@ -42,4 +42,4 @@
 #define z_iounmap iounmap
 #define z_ioremap z_remap_nocache_ser
 
-#endif /* _ASM_ZORRO_H */
+#endif /* _ASM_M68K_ZORRO_H */
--- linux-2.4.23/include/asm-ppc/zorro.h	Mon Apr  1 13:03:12 2002
+++ linux-m68k-2.4.23/include/asm-ppc/zorro.h	Sat Sep 27 16:34:33 2003
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
