Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTITLcP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 07:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTITLcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 07:32:15 -0400
Received: from [203.145.184.221] ([203.145.184.221]:19718 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S261838AbTITLcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 07:32:14 -0400
From: Shine Mohamed <shinemohamed_j@naturesoft.net>
Organization: Naturesoft
To: trivial@rustcorp.com.au
Subject: [TRIVIAL PATCH] Removed unused symbol from isicom.c
Date: Sat, 20 Sep 2003 17:03:20 +0530
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309201703.20420.shinemohamed_j@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick patch to remove unused variables in isicom.c


diff -urN linux-2.6.0-test5.orig/drivers/char/isicom.c 
linux-2.6.0-test5/drivers/char/isicom.c
--- linux-2.6.0-test5.orig/drivers/char/isicom.c        2003-09-09 
01:19:51.000000000 +0530
+++ linux-2.6.0-test5/drivers/char/isicom.c     2003-09-20 15:44:31.000000000 
+0530
@@ -958,7 +958,6 @@
        struct isi_port * port;
        struct isi_board * card;
        unsigned int line, board;
-       unsigned long flags;
        int error;

 #ifdef ISICOM_DEBUG


