Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSIAKtM>; Sun, 1 Sep 2002 06:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSIAKtM>; Sun, 1 Sep 2002 06:49:12 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:36105 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316610AbSIAKtL>; Sun, 1 Sep 2002 06:49:11 -0400
Date: Sun, 1 Sep 2002 12:53:35 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] warnkill trivia 1/2
Message-ID: <20020901105335.GG32122@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 5 days, 8:49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-pre5: Include a missing prototype.


diff -urN linux-2.4.20-pre5/fs/reiserfs/hashes.c linux-2.4.20-pre5.n/fs/reiserfs/hashes.c
--- linux-2.4.20-pre5/fs/reiserfs/hashes.c	2002-09-01 12:48:09.000000000 +0200
+++ linux-2.4.20-pre5.n/fs/reiserfs/hashes.c	2002-09-01 12:03:00.000000000 +0200
@@ -18,6 +18,7 @@
 // r5_hash
 //
 
+#include <linux/kernel.h>	/* for printk() as called by BUG() */
 #include <asm/types.h>
 #include <asm/page.h>
 
