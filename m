Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263782AbTCUSo6>; Fri, 21 Mar 2003 13:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263777AbTCUSng>; Fri, 21 Mar 2003 13:43:36 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17284
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263772AbTCUSmy>; Fri, 21 Mar 2003 13:42:54 -0500
Date: Fri, 21 Mar 2003 19:58:09 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211958.h2LJw91a026151@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: S/390 typo fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-s390x/bitops.h linux-2.5.65-ac2/include/asm-s390x/bitops.h
--- linux-2.5.65/include/asm-s390x/bitops.h	2003-03-03 19:20:16.000000000 +0000
+++ linux-2.5.65-ac2/include/asm-s390x/bitops.h	2003-03-20 18:46:14.000000000 +0000
@@ -55,7 +55,7 @@
 
 #ifdef CONFIG_SMP
 /*
- * SMP save set_bit routine based on compare and swap (CS)
+ * SMP safe set_bit routine based on compare and swap (CS)
  */
 static inline void set_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
@@ -80,7 +80,7 @@
 }
 
 /*
- * SMP save clear_bit routine based on compare and swap (CS)
+ * SMP safe clear_bit routine based on compare and swap (CS)
  */
 static inline void clear_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
@@ -105,7 +105,7 @@
 }
 
 /*
- * SMP save change_bit routine based on compare and swap (CS)
+ * SMP safe change_bit routine based on compare and swap (CS)
  */
 static inline void change_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
@@ -130,7 +130,7 @@
 }
 
 /*
- * SMP save test_and_set_bit routine based on compare and swap (CS)
+ * SMP safe test_and_set_bit routine based on compare and swap (CS)
  */
 static inline int
 test_and_set_bit_cs(unsigned long nr, volatile unsigned long *ptr)
@@ -157,7 +157,7 @@
 }
 
 /*
- * SMP save test_and_clear_bit routine based on compare and swap (CS)
+ * SMP safe test_and_clear_bit routine based on compare and swap (CS)
  */
 static inline int
 test_and_clear_bit_cs(unsigned long nr, volatile unsigned long *ptr)
@@ -184,7 +184,7 @@
 }
 
 /*
- * SMP save test_and_change_bit routine based on compare and swap (CS) 
+ * SMP safe test_and_change_bit routine based on compare and swap (CS) 
  */
 static inline int
 test_and_change_bit_cs(unsigned long nr, volatile unsigned long *ptr)
