Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268619AbTBZCuy>; Tue, 25 Feb 2003 21:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268627AbTBZCuy>; Tue, 25 Feb 2003 21:50:54 -0500
Received: from [24.77.48.240] ([24.77.48.240]:24633 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268619AbTBZCus>;
	Tue, 25 Feb 2003 21:50:48 -0500
Date: Tue, 25 Feb 2003 19:01:09 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302260301.h1Q319N07257@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - ugliness
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    uglyness -> ugliness

Fixes 8 occurrences in all.

diff -ur a/drivers/net/irda/irda-usb.c b/drivers/net/irda/irda-usb.c
--- a/drivers/net/irda/irda-usb.c	Mon Feb 24 11:05:32 2003
+++ b/drivers/net/irda/irda-usb.c	Tue Feb 25 18:11:58 2003
@@ -120,7 +120,7 @@
 /************************ TRANSMIT ROUTINES ************************/
 /*
  * Receive packets from the IrDA stack and send them on the USB pipe.
- * Handle speed change, timeout and lot's of uglyness...
+ * Handle speed change, timeout and lot's of ugliness...
  */
 
 /*------------------------------------------------------------------*/
diff -ur a/include/asm-cris/uaccess.h b/include/asm-cris/uaccess.h
--- a/include/asm-cris/uaccess.h	Mon Feb 24 11:05:09 2003
+++ b/include/asm-cris/uaccess.h	Tue Feb 25 18:12:01 2003
@@ -126,7 +126,7 @@
  * This gets kind of ugly. We want to return _two_ values in "get_user()"
  * and yet we don't want to do any pointers, because that is too much
  * of a performance impact. Thus we have a few rather ugly macros here,
- * and hide all the uglyness from the user.
+ * and hide all the ugliness from the user.
  *
  * The "__xxx" versions of the user access functions are versions that
  * do not verify the address space, that must have been done previously
diff -ur a/include/asm-i386/uaccess.h b/include/asm-i386/uaccess.h
--- a/include/asm-i386/uaccess.h	Mon Feb 24 11:05:10 2003
+++ b/include/asm-i386/uaccess.h	Tue Feb 25 18:12:03 2003
@@ -101,7 +101,7 @@
  * This gets kind of ugly. We want to return _two_ values in "get_user()"
  * and yet we don't want to do any pointers, because that is too much
  * of a performance impact. Thus we have a few rather ugly macros here,
- * and hide all the uglyness from the user.
+ * and hide all the ugliness from the user.
  *
  * The "__xxx" versions of the user access functions are versions that
  * do not verify the address space, that must have been done previously
diff -ur a/include/asm-ppc/uaccess.h b/include/asm-ppc/uaccess.h
--- a/include/asm-ppc/uaccess.h	Mon Feb 24 11:05:05 2003
+++ b/include/asm-ppc/uaccess.h	Tue Feb 25 18:12:07 2003
@@ -65,7 +65,7 @@
  * This gets kind of ugly. We want to return _two_ values in "get_user()"
  * and yet we don't want to do any pointers, because that is too much
  * of a performance impact. Thus we have a few rather ugly macros here,
- * and hide all the uglyness from the user.
+ * and hide all the ugliness from the user.
  *
  * The "__xxx" versions of the user access functions are versions that
  * do not verify the address space, that must have been done previously
diff -ur a/include/asm-ppc64/uaccess.h b/include/asm-ppc64/uaccess.h
--- a/include/asm-ppc64/uaccess.h	Mon Feb 24 11:05:32 2003
+++ b/include/asm-ppc64/uaccess.h	Tue Feb 25 18:12:05 2003
@@ -73,7 +73,7 @@
  * This gets kind of ugly. We want to return _two_ values in "get_user()"
  * and yet we don't want to do any pointers, because that is too much
  * of a performance impact. Thus we have a few rather ugly macros here,
- * and hide all the uglyness from the user.
+ * and hide all the ugliness from the user.
  *
  * The "__xxx" versions of the user access functions are versions that
  * do not verify the address space, that must have been done previously
diff -ur a/include/asm-sparc/uaccess.h b/include/asm-sparc/uaccess.h
--- a/include/asm-sparc/uaccess.h	Mon Feb 24 11:05:43 2003
+++ b/include/asm-sparc/uaccess.h	Tue Feb 25 18:12:12 2003
@@ -89,7 +89,7 @@
  * This gets kind of ugly. We want to return _two_ values in "get_user()"
  * and yet we don't want to do any pointers, because that is too much
  * of a performance impact. Thus we have a few rather ugly macros here,
- * and hide all the uglyness from the user.
+ * and hide all the ugliness from the user.
  */
 #define put_user(x,ptr) ({ \
 unsigned long __pu_addr = (unsigned long)(ptr); \
diff -ur a/include/asm-sparc64/uaccess.h b/include/asm-sparc64/uaccess.h
--- a/include/asm-sparc64/uaccess.h	Mon Feb 24 11:05:17 2003
+++ b/include/asm-sparc64/uaccess.h	Tue Feb 25 18:12:09 2003
@@ -96,7 +96,7 @@
  * This gets kind of ugly. We want to return _two_ values in "get_user()"
  * and yet we don't want to do any pointers, because that is too much
  * of a performance impact. Thus we have a few rather ugly macros here,
- * and hide all the uglyness from the user.
+ * and hide all the ugliness from the user.
  */
 #define put_user(x,ptr) ({ \
 unsigned long __pu_addr = (unsigned long)(ptr); \
diff -ur a/include/asm-x86_64/uaccess.h b/include/asm-x86_64/uaccess.h
--- a/include/asm-x86_64/uaccess.h	Mon Feb 24 11:05:13 2003
+++ b/include/asm-x86_64/uaccess.h	Tue Feb 25 18:12:17 2003
@@ -79,7 +79,7 @@
  * This gets kind of ugly. We want to return _two_ values in "get_user()"
  * and yet we don't want to do any pointers, because that is too much
  * of a performance impact. Thus we have a few rather ugly macros here,
- * and hide all the uglyness from the user.
+ * and hide all the ugliness from the user.
  *
  * The "__xxx" versions of the user access functions are versions that
  * do not verify the address space, that must have been done previously
