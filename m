Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVHJKWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVHJKWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVHJKWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:22:14 -0400
Received: from verein.lst.de ([213.95.11.210]:2228 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932566AbVHJKWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:22:14 -0400
Date: Wed, 10 Aug 2005 12:22:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove asm-*/hdreg.h
Message-ID: <20050810102206.GA7718@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unused and useless..


Signed-off-by: Christoph Hellwig <hch@lst.de>

--- 1.3/include/asm-alpha/hdreg.h	2004-04-14 01:28:58 +02:00
+++ edited/include/asm-alpha/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-arm/hdreg.h 1.4 vs edited =====
--- 1.4/include/asm-arm/hdreg.h	2004-04-14 01:28:58 +02:00
+++ edited/include/asm-arm/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-arm26/hdreg.h 1.3 vs edited =====
--- 1.3/include/asm-arm26/hdreg.h	2004-04-14 01:28:58 +02:00
+++ edited/include/asm-arm26/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-generic/hdreg.h 1.2 vs edited =====
--- 1.2/include/asm-generic/hdreg.h	2004-04-14 01:29:48 +02:00
+++ edited/include/asm-generic/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1,8 +0,0 @@
-#warning <asm/hdreg.h> is obsolete, please do not use it
-
-#ifndef __ASM_GENERIC_HDREG_H
-#define __ASM_GENERIC_HDREG_H
-
-typedef unsigned long ide_ioreg_t;
-
-#endif /* __ASM_GENERIC_HDREG_H */
===== include/asm-h8300/hdreg.h 1.2 vs edited =====
--- 1.2/include/asm-h8300/hdreg.h	2004-04-14 01:29:48 +02:00
+++ edited/include/asm-h8300/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1,15 +0,0 @@
-/*
- *  linux/include/asm-h8300/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#warning this file is obsolete, please do not use it
-
-#ifndef _H8300_HDREG_H
-#define _H8300_HDREG_H
-
-typedef unsigned int   q40ide_ioreg_t;
-typedef unsigned char * ide_ioreg_t;
-
-#endif /* _H8300_HDREG_H */
===== include/asm-i386/hdreg.h 1.4 vs edited =====
--- 1.4/include/asm-i386/hdreg.h	2004-04-14 01:29:48 +02:00
+++ edited/include/asm-i386/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#warning this file is obsolete, please do not use it
===== include/asm-ia64/hdreg.h 1.2 vs edited =====
--- 1.2/include/asm-ia64/hdreg.h	2004-04-14 01:29:48 +02:00
+++ edited/include/asm-ia64/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1,14 +0,0 @@
-/*
- *  linux/include/asm-ia64/hdreg.h
- *
- *  Copyright (C) 1994-1996  Linus Torvalds & authors
- */
-
-#warning this file is obsolete, please do not use it
-
-#ifndef __ASM_IA64_HDREG_H
-#define __ASM_IA64_HDREG_H
-
-typedef unsigned short ide_ioreg_t;
-
-#endif /* __ASM_IA64_HDREG_H */
===== include/asm-m32r/hdreg.h 1.1 vs edited =====
--- 1.1/include/asm-m32r/hdreg.h	2004-09-17 09:06:56 +02:00
+++ edited/include/asm-m32r/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-m68k/hdreg.h 1.3 vs edited =====
--- 1.3/include/asm-m68k/hdreg.h	2004-04-14 01:29:48 +02:00
+++ edited/include/asm-m68k/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#warning this file is obsolete, please do not use it
===== include/asm-m68knommu/hdreg.h 1.1 vs edited =====
--- 1.1/include/asm-m68knommu/hdreg.h	2002-11-01 17:37:46 +01:00
+++ edited/include/asm-m68knommu/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-m68k/hdreg.h>
===== include/asm-mips/hdreg.h 1.5 vs edited =====
--- 1.5/include/asm-mips/hdreg.h	2004-05-10 13:25:30 +02:00
+++ edited/include/asm-mips/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#warning this file is obsolete, please do not use it
===== include/asm-parisc/hdreg.h 1.3 vs edited =====
--- 1.3/include/asm-parisc/hdreg.h	2004-04-14 01:28:58 +02:00
+++ edited/include/asm-parisc/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-ppc/hdreg.h 1.5 vs edited =====
--- 1.5/include/asm-ppc/hdreg.h	2004-04-14 01:28:58 +02:00
+++ edited/include/asm-ppc/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-ppc64/hdreg.h 1.2 vs edited =====
--- 1.2/include/asm-ppc64/hdreg.h	2004-04-14 01:28:58 +02:00
+++ edited/include/asm-ppc64/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-sh/hdreg.h 1.3 vs edited =====
--- 1.3/include/asm-sh/hdreg.h	2004-04-14 01:28:58 +02:00
+++ edited/include/asm-sh/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-sh64/hdreg.h 1.1 vs edited =====
--- 1.1/include/asm-sh64/hdreg.h	2004-06-29 16:44:46 +02:00
+++ edited/include/asm-sh64/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1,6 +0,0 @@
-#ifndef __ASM_SH64_HDREG_H
-#define __ASM_SH64_HDREG_H
-
-#include <asm-generic/hdreg.h>
-
-#endif /* __ASM_SH64_HDREG_H */
===== include/asm-sparc/hdreg.h 1.2 vs edited =====
--- 1.2/include/asm-sparc/hdreg.h	2004-04-14 01:28:58 +02:00
+++ edited/include/asm-sparc/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-sparc64/hdreg.h 1.2 vs edited =====
--- 1.2/include/asm-sparc64/hdreg.h	2004-04-14 01:28:58 +02:00
+++ edited/include/asm-sparc64/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#include <asm-generic/hdreg.h>
===== include/asm-um/hdreg.h 1.1 vs edited =====
--- 1.1/include/asm-um/hdreg.h	2002-09-06 19:29:29 +02:00
+++ edited/include/asm-um/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1,6 +0,0 @@
-#ifndef __UM_HDREG_H
-#define __UM_HDREG_H
-
-#include "asm/arch/hdreg.h"
-
-#endif
===== include/asm-x86_64/hdreg.h 1.4 vs edited =====
--- 1.4/include/asm-x86_64/hdreg.h	2004-04-14 01:29:48 +02:00
+++ edited/include/asm-x86_64/hdreg.h	2005-03-29 23:10:51 +02:00
@@ -1 +0,0 @@
-#warning this file is obsolete, please do not use it
