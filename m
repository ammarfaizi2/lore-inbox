Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSFOSUk>; Sat, 15 Jun 2002 14:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSFOSUj>; Sat, 15 Jun 2002 14:20:39 -0400
Received: from holomorphy.com ([66.224.33.161]:171 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315454AbSFOSUi>;
	Sat, 15 Jun 2002 14:20:38 -0400
Date: Sat, 15 Jun 2002 11:20:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: remove unnecessary parentheses from expand()
Message-ID: <20020615182020.GP25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure why I forgot to do this, but here is a small bit of tidying up
of some leftover parentheses from the memlist macro removal. The
parentheses are just noise and should go.


Cheers,
Bill



===== mm/page_alloc.c 1.67 vs edited =====
--- 1.67/mm/page_alloc.c	Mon Jun  3 08:25:10 2002
+++ edited/mm/page_alloc.c	Sat Jun 15 11:16:21 2002
@@ -173,7 +173,7 @@
 		area--;
 		high--;
 		size >>= 1;
-		list_add(&(page)->list, &(area)->free_list);
+		list_add(&page->list, &area->free_list);
 		MARK_USED(index, high, area);
 		index += size;
 		page += size;
