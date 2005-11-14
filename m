Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVKNHei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVKNHei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 02:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVKNHei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 02:34:38 -0500
Received: from mgate02.necel.com ([203.180.232.82]:61375 "EHLO
	mgate02.necel.com") by vger.kernel.org with ESMTP id S1750948AbVKNHeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 02:34:37 -0500
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Add missing include in hardirq.h
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
From: Miles Bader <miles@gnu.org>
Message-Id: <20051114073405.B6F083A4@dhapc248.dev.necel.com>
Date: Mon, 14 Nov 2005 16:34:05 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/hardirq.h |    2 ++
 1 file changed, 2 insertions(+)

diff -ruN -X../cludes linux-2.6.14-uc0/include/asm-v850/hardirq.h linux-2.6.14-uc0-v850-20051109/include/asm-v850/hardirq.h
--- linux-2.6.14-uc0/include/asm-v850/hardirq.h	2005-03-04 11:34:09.555534000 +0900
+++ linux-2.6.14-uc0-v850-20051109/include/asm-v850/hardirq.h	2005-11-07 20:16:07.521379000 +0900
@@ -5,6 +5,8 @@
 #include <linux/threads.h>
 #include <linux/cache.h>
 
+#include <asm/irq.h>
+
 typedef struct {
 	unsigned int __softirq_pending;
 } ____cacheline_aligned irq_cpustat_t;
