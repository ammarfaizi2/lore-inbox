Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVCSNTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVCSNTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262477AbVCSNRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:17:50 -0500
Received: from coderock.org ([193.77.147.115]:63879 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262470AbVCSNRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:36 -0500
Subject: [patch 05/10] Spelling cleanups in shrinker code
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, mort@wildopensource.com
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:29 +0100
Message-Id: <20050319131729.943411ECA8@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Just a few small cleanups to make this coherent english.

Signed-Off-By:  Martin Hicks <mort@wildopensource.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/include/linux/mm.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/linux/mm.h~typo-include_linux_mm.h include/linux/mm.h
--- kj/include/linux/mm.h~typo-include_linux_mm.h	2005-03-18 20:05:17.000000000 +0100
+++ kj-domen/include/linux/mm.h	2005-03-18 20:05:17.000000000 +0100
@@ -638,9 +638,9 @@ extern unsigned long do_mremap(unsigned 
  * These functions are passed a count `nr_to_scan' and a gfpmask.  They should
  * scan `nr_to_scan' objects, attempting to free them.
  *
- * The callback must the number of objects which remain in the cache.
+ * The callback must return the number of objects which remain in the cache.
  *
- * The callback will be passes nr_to_scan == 0 when the VM is querying the
+ * The callback will be passed nr_to_scan == 0 when the VM is querying the
  * cache size, so a fastpath for that case is appropriate.
  */
 typedef int (*shrinker_t)(int nr_to_scan, unsigned int gfp_mask);
_
