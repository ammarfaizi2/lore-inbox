Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVCPV53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVCPV53 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVCPV52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:57:28 -0500
Received: from mail.dif.dk ([193.138.115.101]:61159 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262821AbVCPVmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:42:50 -0500
Date: Wed, 16 Mar 2005 22:44:15 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jeff Dike <jdike@karaya.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fixup a comment still refering to verify_area that got missed
 initially... 
Message-ID: <Pine.LNX.4.62.0503162239220.2558@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial patch below that updates a comment to refer to access_ok instead 
of the now deprecated verify_area.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm4-orig/include/asm-um/pgtable.h linux-2.6.11-mm4/include/asm-um/pgtable.h
--- linux-2.6.11-mm4-orig/include/asm-um/pgtable.h	2005-03-16 15:45:35.000000000 +0100
+++ linux-2.6.11-mm4/include/asm-um/pgtable.h	2005-03-16 22:37:54.000000000 +0100
@@ -106,7 +106,7 @@ extern unsigned long end_iomem;
 /*
  * Define this if things work differently on an i386 and an i486:
  * it will (on an i486) warn about kernel memory accesses that are
- * done without a 'verify_area(VERIFY_WRITE,..)'
+ * done without a 'access_ok(VERIFY_WRITE,..)'
  */
 #undef TEST_VERIFY_AREA
 

