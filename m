Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTITFZC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 01:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbTITFZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 01:25:02 -0400
Received: from [203.145.184.221] ([203.145.184.221]:45074 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261508AbTITFZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 01:25:00 -0400
From: Shine Mohamed <shinemohamed_j@naturesoft.net>
Organization: Naturesoft
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] Patch to for Cyclades ISA serial board under 2.6
Date: Sat, 20 Sep 2003 10:56:07 +0530
User-Agent: KMail/1.5
Cc: krishnakumar@naturesoft.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309201056.07380.shinemohamed_j@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick patch to remove unused variables in Cyclades.c


diff -urN linux-2.6.0-test5.orig/drivers/char/cyclades.c 
linux-2.6.0-test5/drivers/char/cyclades.c
--- linux-2.6.0-test5.orig/drivers/char/cyclades.c      2003-09-09 
01:19:57.000000000 +0530
+++ linux-2.6.0-test5/drivers/char/cyclades.c   2003-09-20 09:38:20.000000000 
+0530
@@ -5665,8 +5665,7 @@
 cy_cleanup_module(void)
 {
     int i;
-    int e1, e2;
-    unsigned long flags;
+    int e1;

 #ifndef CONFIG_CYZ_INTR
     if (cyz_timeron){


