Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTBPFH6>; Sun, 16 Feb 2003 00:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbTBPFH6>; Sun, 16 Feb 2003 00:07:58 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:40964 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265543AbTBPFH4>; Sun, 16 Feb 2003 00:07:56 -0500
Subject: [PATCH] 2.5.61 yet more pedantry: complement vs compliment.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Feb 2003 22:09:34 -0700
Message-Id: <1045372175.5611.121.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A compliment is an expression of esteem, respect, affection, or
admiration.  As far as I can tell, this word does not yet have a
place in the kernel source.  

A complement on the other hand, is what is meant in the following
places.  Diffed against 2.5.61 up through cset 1.1043.

Steven

diff -ur linux-2.5.61-1043-orig/Documentation/s390/Debugging390.txt linux-2.5.61-1043/Documentation/s390/Debugging390.txt
--- linux-2.5.61-1043-orig/Documentation/s390/Debugging390.txt	Thu Jan 16 19:21:42 2003
+++ linux-2.5.61-1043/Documentation/s390/Debugging390.txt	Sat Feb 15 21:50:01 2003
@@ -10,7 +10,7 @@
 This document is intended to give an good overview of how to debug 
 Linux for s/390 & z/Architecture it isn't intended as a complete reference & not a
 tutorial on the fundamentals of C & assembly, it dosen't go into
-390 IO in any detail. It is intended to compliment the documents in the
+390 IO in any detail. It is intended to complement the documents in the
 reference section below & any other worthwhile references you get.
 
 It is intended like the Enterprise Systems Architecture/390 Reference Summary
diff -ur linux-2.5.61-1043-orig/arch/alpha/lib/csum_ipv6_magic.S linux-2.5.61-1043/arch/alpha/lib/csum_ipv6_magic.S
--- linux-2.5.61-1043-orig/arch/alpha/lib/csum_ipv6_magic.S	Thu Jan 16 19:21:44 2003
+++ linux-2.5.61-1043/arch/alpha/lib/csum_ipv6_magic.S	Sat Feb 15 21:50:01 2003
@@ -84,7 +84,7 @@
 	extwl	$0,2,$1		# e0    : fold 17-bit value
 	zapnot	$0,3,$0		# .. e1 :
 	addq	$0,$1,$0	# e0    :
-	not	$0,$0		# e1    : and compliment.
+	not	$0,$0		# e1    : and complement.
 
 	zapnot	$0,3,$0		# e0    :
 	ret			# .. e1 :
diff -ur linux-2.5.61-1043-orig/arch/ppc/kernel/irq.c linux-2.5.61-1043/arch/ppc/kernel/irq.c
--- linux-2.5.61-1043-orig/arch/ppc/kernel/irq.c	Thu Jan 16 19:22:30 2003
+++ linux-2.5.61-1043/arch/ppc/kernel/irq.c	Sat Feb 15 21:50:01 2003
@@ -20,7 +20,7 @@
  * The MPC8xx has an interrupt mask in the SIU.  If a bit is set, the
  * interrupt is _enabled_.  As expected, IRQ0 is bit 0 in the 32-bit
  * mask register (of which only 16 are defined), hence the weird shifting
- * and compliment of the cached_irq_mask.  I want to be able to stuff
+ * and complement of the cached_irq_mask.  I want to be able to stuff
  * this right into the SIU SMASK register.
  * Many of the prep/chrp functions are conditional compiled on CONFIG_8xx
  * to reduce code space and undefined function references.
diff -ur linux-2.5.61-1043-orig/drivers/char/rio/rioboot.c linux-2.5.61-1043/drivers/char/rio/rioboot.c
--- linux-2.5.61-1043-orig/drivers/char/rio/rioboot.c	Thu Jan 16 19:21:47 2003
+++ linux-2.5.61-1043/drivers/char/rio/rioboot.c	Sat Feb 15 21:50:01 2003
@@ -410,7 +410,7 @@
 		** compatible with the whole Tp family. (lies, damn lies, it'll never
 		** work in a month of Sundays).
 		**
-		** The nfix nyble is the 1s compliment of the nyble value you
+		** The nfix nyble is the 1s complement of the nyble value you
 		** want to load - in this case we wanted 'F' so we nfix loaded '0'.
 		*/
 
diff -ur linux-2.5.61-1043-orig/drivers/scsi/aic7xxx/aic79xx.reg linux-2.5.61-1043/drivers/scsi/aic7xxx/aic79xx.reg
--- linux-2.5.61-1043-orig/drivers/scsi/aic7xxx/aic79xx.reg	Mon Feb 10 12:23:02 2003
+++ linux-2.5.61-1043/drivers/scsi/aic7xxx/aic79xx.reg	Sat Feb 15 21:50:01 2003
@@ -3725,7 +3725,7 @@
 
 	/*
 	 * The minimum number of commands still outstanding required
-	 * to continue coalessing (2's compliment of value).
+	 * to continue coalessing (2's complement of value).
 	 */
 	INT_COALESSING_MINCMDS {
 		size		1
diff -ur linux-2.5.61-1043-orig/include/asm-mips64/sn/launch.h linux-2.5.61-1043/include/asm-mips64/sn/launch.h
--- linux-2.5.61-1043-orig/include/asm-mips64/sn/launch.h	Thu Jan 16 19:22:44 2003
+++ linux-2.5.61-1043/include/asm-mips64/sn/launch.h	Sat Feb 15 21:50:01 2003
@@ -52,7 +52,7 @@
 /*
  * The launch routine is called only if the complement address is correct.
  *
- * Before control is transferred to a routine, the compliment address
+ * Before control is transferred to a routine, the complement address
  * is zeroed (invalidated) to prevent an accidental call from a spurious
  * interrupt.
  *
diff -ur linux-2.5.61-1043-orig/include/asm-mips64/sn/nmi.h linux-2.5.61-1043/include/asm-mips64/sn/nmi.h
--- linux-2.5.61-1043-orig/include/asm-mips64/sn/nmi.h	Thu Jan 16 19:22:13 2003
+++ linux-2.5.61-1043/include/asm-mips64/sn/nmi.h	Sat Feb 15 21:50:01 2003
@@ -42,7 +42,7 @@
  * The NMI routine is called only if the complement address is
  * correct.
  *
- * Before control is transferred to a routine, the compliment address
+ * Before control is transferred to a routine, the complement address
  * is zeroed (invalidated) to prevent an accidental call from a spurious
  * interrupt.
  *
diff -ur linux-2.5.61-1043-orig/include/asm-sparc64/ptrace.h linux-2.5.61-1043/include/asm-sparc64/ptrace.h
--- linux-2.5.61-1043-orig/include/asm-sparc64/ptrace.h	Thu Jan 16 19:22:21 2003
+++ linux-2.5.61-1043/include/asm-sparc64/ptrace.h	Sat Feb 15 21:50:01 2003
@@ -268,7 +268,7 @@
 #define PTRACE_SETFPAREGS         21
 
 /* There are for debugging 64-bit processes, either from a 32 or 64 bit
- * parent.  Thus their compliments are for debugging 32-bit processes only.
+ * parent.  Thus their complements are for debugging 32-bit processes only.
  */
 
 #define PTRACE_GETREGS64	  22



