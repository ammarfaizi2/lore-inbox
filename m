Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289306AbSBSTYN>; Tue, 19 Feb 2002 14:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289240AbSBSTYE>; Tue, 19 Feb 2002 14:24:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47369 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289074AbSBSTXr>; Tue, 19 Feb 2002 14:23:47 -0500
Date: Tue, 19 Feb 2002 11:21:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH *] new struct page shrinkage
In-Reply-To: <Pine.LNX.4.33L.0202191131050.1930-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.33.0202191116470.27806-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2002, Rik van Riel wrote:
>
> The patch has been changed like you wanted, with page->zone
> shoved into page->flags. I've also pulled the thing up to
> your latest changes from linux.bkbits.net so you should be
> able to just pull it into your tree from:
>
> bk://linuxvm.bkbits.net/linux-2.5-struct_page

Btw, _please_ don't do things like changing the bitkeeper etc/config file.
Right now your very first changesets is something that I definitely do not
want in my tree.

Sure, I can do "bk cset -x" on the damn thing, but the fact is, I don't
want to have totally unnecessary undo's in my tree on things like this.
That's just stupid, and only makes the revision history look even less
readable than it already is..

		Linus

