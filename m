Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVHLSPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVHLSPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVHLSPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:15:15 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:47821 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750715AbVHLSPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:15:14 -0400
Subject: [patch 01/39] comment typo fix
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:20:56 +0200
Message-Id: <20050812182057.1DC0C24B4FD@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

smp_entry_t -> swap_entry_t

Too short changelog entry?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/linux/swapops.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/linux/swapops.h~fix-typo include/linux/swapops.h
--- linux-2.6.git/include/linux/swapops.h~fix-typo	2005-08-11 11:12:23.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/swapops.h	2005-08-11 11:12:24.000000000 +0200
@@ -4,7 +4,7 @@
  * the low-order bits.
  *
  * We arrange the `type' and `offset' fields so that `type' is at the five
- * high-order bits of the smp_entry_t and `offset' is right-aligned in the
+ * high-order bits of the swap_entry_t and `offset' is right-aligned in the
  * remaining bits.
  *
  * swp_entry_t's are *never* stored anywhere in their arch-dependent format.
_
