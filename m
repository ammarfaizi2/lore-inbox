Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVKFGRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVKFGRj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 01:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVKFGRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 01:17:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:62360 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750769AbVKFGRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 01:17:38 -0500
Date: Sat, 5 Nov 2005 22:17:28 -0800
From: Paul Jackson <pj@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: ak@suse.de, akpm@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Does shmem_getpage==>shmem_alloc_page==>alloc_page_vma hold
 mmap_sem?
Message-Id: <20051105221728.3fa25f69.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0511060547120.14675@goblin.wat.veritas.com>
References: <20051105212133.714da0d2.pj@sgi.com>
	<Pine.LNX.4.61.0511060547120.14675@goblin.wat.veritas.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh wrote:
> It's safe but horrid.

Ok - thanks for the explanation.

Now I don't feel so bad about some of my cpuset locking hacks.

(Yes, Andrew, I'm still looking at my latest hack, 
the down_write_trylock() call in cpuset.c refresh_mems.)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
