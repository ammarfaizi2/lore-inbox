Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132777AbRDIQA5>; Mon, 9 Apr 2001 12:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132784AbRDIQAi>; Mon, 9 Apr 2001 12:00:38 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:58555 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132777AbRDIQA2>; Mon, 9 Apr 2001 12:00:28 -0400
Date: Mon, 9 Apr 2001 17:01:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.4-pre1 sparc/mm typo
In-Reply-To: <Pine.LNX.4.21.0103301457460.1080-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0104091653370.1028-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 2.4.4-pre1/arch/sparc/mm/generic.c	Sat Apr  7 08:15:16 2001
+++ linux/arch/sparc/mm/generic.c	Mon Apr  9 16:48:42 2001
@@ -21,7 +21,7 @@
 		struct page *ptpage = pte_page(page);
 		if ((!VALID_PAGE(ptpage)) || PageReserved(ptpage))
 			return;
-		page_cache_release(page);
+		page_cache_release(ptpage);
 		return;
 	}
 	swap_free(pte_to_swp_entry(page));

