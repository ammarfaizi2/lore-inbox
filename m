Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTJLRUo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 13:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTJLRUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 13:20:44 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:62085 "EHLO
	cluless.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263491AbTJLRUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 13:20:43 -0400
Date: Sun, 12 Oct 2003 13:20:27 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cluless.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, <Matt_Domsch@Dell.com>,
       <marcelo.tosatti@cyclades.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <20031012143617.GS16013@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0310121319210.31175-100000@cluless.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Oct 2003, Andrea Arcangeli wrote:

> we can argue about the filemap.c part, but I'm sure the page_alloc.c
> part can't make any sense ever.

Agreed, the __free_pages_ok() change can almost certainly be
undone and made more efficient.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

