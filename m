Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTC0RV4>; Thu, 27 Mar 2003 12:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263323AbTC0RVG>; Thu, 27 Mar 2003 12:21:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57989
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263319AbTC0RJT>; Thu, 27 Mar 2003 12:09:19 -0500
Date: Thu, 27 Mar 2003 18:26:46 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271826.h2RIQk4e019714@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

S/390 typo fixes
(Steven Cole)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/include/asm-s390/bitops.h linux-2.5.66-ac1/include/asm-s390/bitops.h
--- linux-2.5.66-bk3/include/asm-s390/bitops.h	2003-03-27 17:13:28.000000000 +0000
+++ linux-2.5.66-ac1/include/asm-s390/bitops.h	2003-03-20 18:46:00.000000000 +0000
@@ -51,7 +51,7 @@
 
 #ifdef CONFIG_SMP
 /*
- * SMP save set_bit routine based on compare and swap (CS)
+ * SMP safe set_bit routine based on compare and swap (CS)
  */
 static inline void set_bit_cs(int nr, volatile unsigned long *ptr)
 {
@@ -76,7 +76,7 @@
 }
 
 /*
- * SMP save clear_bit routine based on compare and swap (CS)
+ * SMP safe clear_bit routine based on compare and swap (CS)
  */
 static inline void clear_bit_cs(int nr, volatile unsigned long *ptr)
 {
@@ -101,7 +101,7 @@
 }
 
 /*
- * SMP save change_bit routine based on compare and swap (CS)
+ * SMP safe change_bit routine based on compare and swap (CS)
  */
 static inline void change_bit_cs(int nr, volatile unsigned long *ptr)
 {
@@ -126,7 +126,7 @@
 }
 
 /*
- * SMP save test_and_set_bit routine based on compare and swap (CS)
+ * SMP safe test_and_set_bit routine based on compare and swap (CS)
  */
 static inline int
 test_and_set_bit_cs(int nr, volatile unsigned long *ptr)
@@ -153,7 +153,7 @@
 }
 
 /*
- * SMP save test_and_clear_bit routine based on compare and swap (CS)
+ * SMP safe test_and_clear_bit routine based on compare and swap (CS)
  */
 static inline int
 test_and_clear_bit_cs(int nr, volatile unsigned long *ptr)
@@ -180,7 +180,7 @@
 }
 
 /*
- * SMP save test_and_change_bit routine based on compare and swap (CS) 
+ * SMP safe test_and_change_bit routine based on compare and swap (CS) 
  */
 static inline int
 test_and_change_bit_cs(int nr, volatile unsigned long *ptr)
