Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVAQDkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVAQDkF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVAQDgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:36:09 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:22276
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262680AbVAQDd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:57 -0500
Message-Id: <200501170556.j0H5uRkY006087@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] UML - Define __HAVE_ARCH_CMPXCHG on x86
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:56:27 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/include/asm-um/system-i386.h
===================================================================
--- 2.6.10.orig/include/asm-um/system-i386.h	2004-12-24 16:34:31.000000000 -0500
+++ 2.6.10/include/asm-um/system-i386.h	2005-01-16 21:14:34.000000000 -0500
@@ -3,4 +3,6 @@
 
 #include "asm/system-generic.h"
     
+#define __HAVE_ARCH_CMPXCHG 1
+
 #endif

