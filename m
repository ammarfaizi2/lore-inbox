Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbTIYPBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 11:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTIYPBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 11:01:16 -0400
Received: from [203.145.184.221] ([203.145.184.221]:30214 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261260AbTIYPBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 11:01:15 -0400
From: Shine Mohamed <shinemohamed_j@naturesoft.net>
Organization: Naturesoft
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Patch to for Cyclades ISA serial board under 2.6
Date: Thu, 25 Sep 2003 20:32:57 +0530
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Cc: krishnakumar@naturesoft.net
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309252032.57513.shinemohamed_j@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick patch to remove unused variables in Cyclades.c
This patch was sent earlier but the patching was done in wrong way 
.... So submitting a correctly patched one.

--- drivers/char/cyclades.c.orig        2003-09-25 19:04:22.000000000 +0530
+++ drivers/char/cyclades.c     2003-09-25 19:07:45.000000000 +0530
@@ -5665,8 +5665,7 @@
 cy_cleanup_module(void)
 {
     int i;
-    int e1, e2;
-    unsigned long flags;
+    int e1;

 #ifndef CONFIG_CYZ_INTR
     if (cyz_timeron){


