Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289372AbSBSTzR>; Tue, 19 Feb 2002 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSBSTzI>; Tue, 19 Feb 2002 14:55:08 -0500
Received: from bitmover.com ([192.132.92.2]:41407 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289657AbSBSTyy>;
	Tue, 19 Feb 2002 14:54:54 -0500
Date: Tue, 19 Feb 2002 11:54:52 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Amy Graf <amy@bitmover.com>
Subject: Re: [PATCH *] new struct page shrinkage
Message-ID: <20020219115452.S26350@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Amy Graf <amy@work.bitmover.com>
In-Reply-To: <20020219113217.P26350@work.bitmover.com> <Pine.LNX.4.33L.0202191634290.7820-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0202191634290.7820-100000@imladris.surriel.com>; from riel@conectiva.com.br on Tue, Feb 19, 2002 at 04:35:26PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 04:35:26PM -0300, Rik van Riel wrote:
> On Tue, 19 Feb 2002, Larry McVoy wrote:
> > This is really a problem for bkbits to solve if I understand it
> > correctly. Rik wants to "name" his tree.  If we the bkbits admin
> > interface have a "desc" command which changes the description listed
> > on the web pages, then I think he'll be happy, right?
> 
> Indeed.  The problem was that I was getting too many trees
> on linuxvm.bkbits.net and would only end up confusing people
> what was what...

I've got Amy working on a change so you can do a 

admin shell>> desc [-rrepo] whatever you want

and it will change the description to "whatever you want" on repo if specified,
or all if not.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
