Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266776AbSKHIIv>; Fri, 8 Nov 2002 03:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266779AbSKHIIv>; Fri, 8 Nov 2002 03:08:51 -0500
Received: from dp.samba.org ([66.70.73.150]:37048 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266776AbSKHIIr>;
	Fri, 8 Nov 2002 03:08:47 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] fix documentation in include_asm-i386_bitops.h
Date: Fri, 08 Nov 2002 18:51:34 +1100
Message-Id: <20021108081529.1BD922C37A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  "Vitezslav Samel" <samel@mail.cz>

    Whean I was searching for prototype for set_bit() I found IMHO wrong doc
  entries in include/asm-i386/bitops.h. Please consider applying.
  
  	Cheers,
  		Vita

--- trivial-2.5-bk/include/asm-i386/bitops.h.orig	2002-11-08 18:46:34.000000000 +1100
+++ trivial-2.5-bk/include/asm-i386/bitops.h	2002-11-08 18:46:34.000000000 +1100
@@ -89,7 +89,7 @@
 
 /**
  * __change_bit - Toggle a bit in memory
- * @nr: the bit to set
+ * @nr: the bit to change
  * @addr: the address to start counting from
  *
  * Unlike change_bit(), this function is non-atomic and may be reordered.
@@ -106,7 +106,7 @@
 
 /**
  * change_bit - Toggle a bit in memory
- * @nr: Bit to clear
+ * @nr: Bit to change
  * @addr: Address to start counting from
  *
  * change_bit() is atomic and may not be reordered.
@@ -162,7 +162,7 @@
 
 /**
  * test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to set
+ * @nr: Bit to clear
  * @addr: Address to count from
  *
  * This operation is atomic and cannot be reordered.  
@@ -181,7 +181,7 @@
 
 /**
  * __test_and_clear_bit - Clear a bit and return its old value
- * @nr: Bit to set
+ * @nr: Bit to clear
  * @addr: Address to count from
  *
  * This operation is non-atomic and can be reordered.  
@@ -213,7 +213,7 @@
 
 /**
  * test_and_change_bit - Change a bit and return its new value
- * @nr: Bit to set
+ * @nr: Bit to change
  * @addr: Address to count from
  *
  * This operation is atomic and cannot be reordered.  
-- 
  Don't blame me: the Monkey is driving
  File: "Vitezslav Samel" <samel@mail.cz>: fix documentation in include_asm-i386_bitops.h
