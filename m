Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWE2TSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWE2TSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 15:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWE2TSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 15:18:35 -0400
Received: from xenotime.net ([66.160.160.81]:52152 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751221AbWE2TSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 15:18:34 -0400
Date: Mon, 29 May 2006 12:21:09 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: mm/readhead fixup
Message-Id: <20060529122109.4256d249.rdunlap@xenotime.net>
In-Reply-To: <20060529122009.3fbd4c66.akpm@osdl.org>
References: <20060529120729.454f5d0c.rdunlap@xenotime.net>
	<20060529122009.3fbd4c66.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 12:20:09 -0700 Andrew Morton wrote:

> On Mon, 29 May 2006 12:07:29 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Put short function description for read_cache_pages() on one line
> > as needed by kernel-doc.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  mm/readahead.c |    3 +--
> >  1 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > --- linux-2617-rc5.orig/mm/readahead.c
> > +++ linux-2617-rc5/mm/readahead.c
> > @@ -118,8 +118,7 @@ static inline unsigned long get_next_ra_
> >  #define list_to_page(head) (list_entry((head)->prev, struct page, lru))
> >  
> >  /**
> > - * read_cache_pages - populate an address space with some pages, and
> > - * 			start reads against them.
> > + * read_cache_pages - populate an address space with some pages & start reads against them
> >   * @mapping: the address_space
> >   * @pages: The address of a list_head which contains the target pages.  These
> >   *   pages have their ->index populated and are otherwise uninitialised.
> 
> Can kernel-doc be fixed?  (I can't see how, give the vague syntax).

I don't know.  It's on my list to look at.
I expect that it will require some small syntax changes (but
should maintain backward compatibility).

---
~Randy
