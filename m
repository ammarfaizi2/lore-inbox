Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279749AbRJ3C12>; Mon, 29 Oct 2001 21:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279752AbRJ3C1R>; Mon, 29 Oct 2001 21:27:17 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:51885 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S279749AbRJ3C07>; Mon, 29 Oct 2001 21:26:59 -0500
Date: Tue, 30 Oct 2001 02:29:17 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pre5 export free_lru_page
Message-ID: <Pine.LNX.4.21.0110300226580.932-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 2.4.14-pre5/kernel/ksyms.c	Tue Oct 30 01:40:29 2001
+++ linux/kernel/ksyms.c	Tue Oct 30 02:05:03 2001
@@ -94,6 +94,7 @@
 EXPORT_SYMBOL(alloc_pages_node);
 EXPORT_SYMBOL(__get_free_pages);
 EXPORT_SYMBOL(get_zeroed_page);
+EXPORT_SYMBOL(free_lru_page);
 EXPORT_SYMBOL(__free_pages);
 EXPORT_SYMBOL(free_pages);
 EXPORT_SYMBOL(num_physpages);

