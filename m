Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSJWAv0>; Tue, 22 Oct 2002 20:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJWAv0>; Tue, 22 Oct 2002 20:51:26 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:29892 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262324AbSJWAvZ>; Tue, 22 Oct 2002 20:51:25 -0400
Date: Tue, 22 Oct 2002 20:49:56 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.44-ac1 : remove STATIC macro within archs
Message-ID: <Pine.LNX.4.44.0210222042200.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following set of patches removes the STATIC macro with the archs 
(i386, sh, x86_64, arm, cris).

Regards,
Frank

--- linux/arch/i386/boot/compressed/misc.c.old	Tue Oct 22 18:22:51 2002
+++ linux/arch/i386/boot/compressed/misc.c	Tue Oct 22 19:49:22 2002
@@ -19,7 +19,6 @@
  */
 
 #define OF(args)  args
-#define STATIC static
 
 #undef memset
 #undef memcpy

--- linux/arch/sh/boot/compressed/misc.c.old	Sat Oct 19 12:03:31 2002
+++ linux/arch/sh/boot/compressed/misc.c	Tue Oct 22 19:50:46 2002
@@ -22,7 +22,6 @@
  */
 
 #define OF(args)  args
-#define STATIC static
 
 #undef memset
 #undef memcpy

--- linux/arch/x86_64/boot/compressed/misc.c.old	Sat Oct 19 12:03:48 2002
+++ linux/arch/x86_64/boot/compressed/misc.c	Tue Oct 22 19:52:20 2002
@@ -17,7 +17,6 @@
  */
 
 #define OF(args)  args
-#define STATIC static
 
 #undef memset
 #undef memcpy

--- linux/arch/arm/boot/compressed/misc.c.old	Sat Oct 19 12:02:21 2002
+++ linux/arch/arm/boot/compressed/misc.c	Tue Oct 22 19:46:17 2002
@@ -113,7 +113,6 @@
  * gzip delarations
  */
 #define OF(args)  args
-#define STATIC static
 
 typedef unsigned char  uch;
 typedef unsigned short ush;


--- linux/arch/cris/boot/compressed/misc.c.old	Sat Oct 19 12:02:30 2002
+++ linux/arch/cris/boot/compressed/misc.c	Tue Oct 22 19:47:58 2002
@@ -30,7 +30,6 @@
  */
 
 #define OF(args)  args
-#define STATIC static
 
 void* memset(void* s, int c, size_t n);
 void* memcpy(void* __dest, __const void* __src,

