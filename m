Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267789AbUGWPQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267789AbUGWPQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 11:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267790AbUGWPQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 11:16:28 -0400
Received: from baikonur.stro.at ([213.239.196.228]:11456 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267789AbUGWPQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 11:16:26 -0400
Date: Fri, 23 Jul 2004 17:16:24 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-mtd@lists.infradead.org
Cc: dwmw2@redhat.com, linux-kernel@vger.kernel.org
Subject: [patch-kj] remove old ifdefs drivers/mtd/mtdcore.c
Message-ID: <20040723151624.GM1795@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 remove unused #include <linux/version.h>
 Patches to remove old ifdefs 2.2 compatibility is already merged.

applies cleanly to 2.6.8-rc2

From: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.7-bk20-max/drivers/mtd/mtdcore.c |   36 -----------------------------
 1 files changed, 1 insertion(+), 35 deletions(-)

diff -puN drivers/mtd/mtdcore.c~remove-old-ifdefs-mtdcore drivers/mtd/mtdcore.c
--- linux-2.6.7-bk20/drivers/mtd/mtdcore.c~remove-old-ifdefs-mtdcore	2004-07-11 14:42:37.000000000 +0200
+++ linux-2.6.7-bk20-max/drivers/mtd/mtdcore.c	2004-07-11 14:42:37.000000000 +0200
@@ -6,7 +6,6 @@
  *
  */
 
-#include <linux/version.h>
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
