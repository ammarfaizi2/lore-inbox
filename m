Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289564AbSBSTco>; Tue, 19 Feb 2002 14:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289339AbSBSTcf>; Tue, 19 Feb 2002 14:32:35 -0500
Received: from bitmover.com ([192.132.92.2]:16319 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289347AbSBSTcW>;
	Tue, 19 Feb 2002 14:32:22 -0500
Date: Tue, 19 Feb 2002 11:32:17 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH *] new struct page shrinkage
Message-ID: <20020219113217.P26350@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.33L.0202191131050.1930-100000@imladris.surriel.com> <Pine.LNX.4.33.0202191116470.27806-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202191116470.27806-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 19, 2002 at 11:21:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 11:21:34AM -0800, Linus Torvalds wrote:
> > The patch has been changed like you wanted, with page->zone
> > shoved into page->flags. I've also pulled the thing up to
> > your latest changes from linux.bkbits.net so you should be
> > able to just pull it into your tree from:
> >
> > bk://linuxvm.bkbits.net/linux-2.5-struct_page
> 
> Btw, _please_ don't do things like changing the bitkeeper etc/config file.
> Right now your very first changesets is something that I definitely do not
> want in my tree.

This is really a problem for bkbits to solve if I understand it correctly.
Rik wants to "name" his tree.  If we the bkbits admin interface have a 
"desc" command which changes the description listed on the web pages, then
I think he'll be happy, right?  We had the same problem with the PPC tree,
people do this without realizing the implications.

I'd suggest a changeset to the config file which says 

# Don't change the description unless you are Linus.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
