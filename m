Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOCzt>; Thu, 14 Dec 2000 21:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130120AbQLOCzj>; Thu, 14 Dec 2000 21:55:39 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:47805 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129267AbQLOCze>; Thu, 14 Dec 2000 21:55:34 -0500
Message-ID: <3A39805D.B6A3AFE0@didntduck.org>
Date: Thu, 14 Dec 2000 21:22:21 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Makefile fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch should be obviously correct.

diff -urN linux-2.4.0t13p1/arch/i386/Makefile linux/arch/i386/Makefile
--- linux-2.4.0t13p1/arch/i386/Makefile Thu Dec 14 20:54:41 2000
+++ linux/arch/i386/Makefile    Thu Dec 14 21:04:34 2000
@@ -91,7 +91,7 @@
 
 ifdef CONFIG_MATH_EMULATION
 SUBDIRS += arch/i386/math-emu
-SUBDIRS += arch/i386/math-emu/math.o
+DRIVERS += arch/i386/math-emu/math.o
 endif
 
 arch/i386/kernel: dummy
-- 

						Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
