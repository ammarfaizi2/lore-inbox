Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUIWUSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUIWUSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 16:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUIWUSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:18:04 -0400
Received: from baikonur.stro.at ([213.239.196.228]:16790 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S264443AbUIWUR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:17:58 -0400
Subject: [patch 2/3]  remove old ifdefs dmascc
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:17:59 +0200
Message-ID: <E1CAa2R-0006xi-RJ@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Patches to remove some old ifdefs.
 remove most of the #include <linux/version.h>
 kill compat cruft like #define ahd_pci_set_dma_mask pci_set_dma_mask

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/net/hamradio/dmascc.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/net/hamradio/dmascc.c~remove-old-ifdefs-dmascc drivers/net/hamradio/dmascc.c
--- linux-2.6.9-rc2-bk7/drivers/net/hamradio/dmascc.c~remove-old-ifdefs-dmascc	2004-09-21 20:46:56.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/net/hamradio/dmascc.c	2004-09-21 20:46:56.000000000 +0200
@@ -37,7 +37,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/sockios.h>
 #include <linux/workqueue.h>
-#include <linux/version.h>
 #include <asm/atomic.h>
 #include <asm/bitops.h>
 #include <asm/dma.h>
_
