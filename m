Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272992AbTGaLGm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272993AbTGaLGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:06:42 -0400
Received: from [203.145.184.221] ([203.145.184.221]:6672 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S272992AbTGaLGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:06:40 -0400
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: trivial@rustcorp.com.au
Subject: [TRIVIAL][PATCH-2.6.0-test2] Remove unused variable.
Date: Thu, 31 Jul 2003 16:39:24 +0530
User-Agent: KMail/1.5
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307311639.24432.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This removes the following warning while compiling.

drivers/char/cyclades.c: In function `cy_cleanup_module':
drivers/char/cyclades.c:5668: warning: unused variable `e2'


The patch is against the linux-2.6.0-test2.

Regards
KK



--- linux-2.6.0-test2/drivers/char/cyclades.orig.c	2003-07-31 16:16:49.000000000 +0530
+++ linux-2.6.0-test2/drivers/char/cyclades.c	2003-07-31 16:30:12.000000000 +0530
@@ -5665,7 +5665,7 @@
 cy_cleanup_module(void)
 {
     int i;
-    int e1, e2;
+    int e1;
     unsigned long flags;
 
 #ifndef CONFIG_CYZ_INTR













