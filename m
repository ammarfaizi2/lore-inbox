Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315331AbSDWTvu>; Tue, 23 Apr 2002 15:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315332AbSDWTvt>; Tue, 23 Apr 2002 15:51:49 -0400
Received: from newman.edw2.uc.edu ([129.137.2.198]:36875 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S315331AbSDWTvs>;
	Tue, 23 Apr 2002 15:51:48 -0400
From: kuebelr@email.uc.edu
Date: Tue, 23 Apr 2002 15:50:52 -0400
To: torvalds@transmeta.com, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] spelling mistakes
Message-Id: <20020423195052.GA967@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a few spelling mistakes in documentation (arch/i386/boot/setup.S,
Documentation/sysrq.txt).  Pretty boring.  This is against 2.4.19-pre7,
but also applies to 2.5.9.

Thanks.
Rob.

diff -Naur linux-2.4/Documentation/sysrq.txt linux-2.4-work/Documentation/sysrq.txt
--- linux-2.4/Documentation/sysrq.txt	Tue Sep 18 01:52:35 2001
+++ linux-2.4-work/Documentation/sysrq.txt	Tue Apr 23 10:55:44 2002
@@ -153,7 +153,7 @@
 and 4 functions are exported for interface to it: __sysrq_lock_table,
 __sysrq_unlock_table, __sysrq_get_key_op, and __sysrq_put_key_op. The
 functions __sysrq_swap_key_ops and __sysrq_swap_key_ops_nolock are defined
-in the header itself, and the REGISTER and UNREGISTER macros are built fromi
+in the header itself, and the REGISTER and UNREGISTER macros are built from
 these. More complex (and dangerous!) manipulations of the table are possible
 using these functions, but you must be careful to always lock the table before
 you read or write from it, and to unlock it again when you are done. (And of
diff -Naur linux-2.4/arch/i386/boot/setup.S linux-2.4-work/arch/i386/boot/setup.S
--- linux-2.4/arch/i386/boot/setup.S	Mon Feb 25 14:37:52 2002
+++ linux-2.4-work/arch/i386/boot/setup.S	Tue Apr 23 10:54:02 2002
@@ -805,7 +805,7 @@
 #
 #	but we yet haven't reloaded the CS register, so the default size 
 #	of the target offset still is 16 bit.
-#       However, using an operant prefix (0x66), the CPU will properly
+#       However, using an operand prefix (0x66), the CPU will properly
 #	take our 48 bit far pointer. (INTeL 80386 Programmer's Reference
 #	Manual, Mixing 16-bit and 32-bit code, page 16-6)
 
