Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWE2TPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWE2TPv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWE2TPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:15:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751194AbWE2TPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:15:50 -0400
Date: Mon, 29 May 2006 12:20:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: mm/readhead fixup
Message-Id: <20060529122009.3fbd4c66.akpm@osdl.org>
In-Reply-To: <20060529120729.454f5d0c.rdunlap@xenotime.net>
References: <20060529120729.454f5d0c.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 12:07:29 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Put short function description for read_cache_pages() on one line
> as needed by kernel-doc.
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  mm/readahead.c |    3 +--
>  1 files changed, 1 insertion(+), 2 deletions(-)
> 
> --- linux-2617-rc5.orig/mm/readahead.c
> +++ linux-2617-rc5/mm/readahead.c
> @@ -118,8 +118,7 @@ static inline unsigned long get_next_ra_
>  #define list_to_page(head) (list_entry((head)->prev, struct page, lru))
>  
>  /**
> - * read_cache_pages - populate an address space with some pages, and
> - * 			start reads against them.
> + * read_cache_pages - populate an address space with some pages & start reads against them
>   * @mapping: the address_space
>   * @pages: The address of a list_head which contains the target pages.  These
>   *   pages have their ->index populated and are otherwise uninitialised.

Can kernel-doc be fixed?  (I can't see how, give the vague syntax).
