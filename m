Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262345AbREUUdQ>; Mon, 21 May 2001 16:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbREUUdG>; Mon, 21 May 2001 16:33:06 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:16288 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S262345AbREUUc4>;
	Mon, 21 May 2001 16:32:56 -0400
Date: Mon, 21 May 2001 22:32:12 +0200
From: David Weinehall <tao@acc.umu.se>
To: Pavel Machek <pavel@suse.cz>
Cc: Rik van Riel <riel@conectiva.com.br>, Mike Galbraith <mikeg@wen-online.de>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
Message-ID: <20010521223212.C4934@khan.acc.umu.se>
In-Reply-To: <Pine.LNX.4.33.0105200957500.323-100000@mikeg.weiden.de> <Pine.LNX.4.21.0105200546241.5531-100000@imladris.rielhome.conectiva> <20010520235409.G2647@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20010520235409.G2647@bug.ucw.cz>; from pavel@suse.cz on Sun, May 20, 2001 at 11:54:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 11:54:09PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > You're right.  It should never dump too much data at once.  OTOH, if
> > > those cleaned pages are really old (front of reclaim list), there's no
> > > value in keeping them either.  Maybe there should be a slow bleed for
> > > mostly idle or lightly loaded conditions.
> > 
> > If you don't think it's worthwhile keeping the oldest pages
> > in memory around, please hand me your excess DIMMS ;)
> 
> Sorry, Rik, you can't have that that DIMM. You know, you are
> developing memory managment, and we can't have you having too much
> memory available ;-).

IMVHO every developer involved in memory-management (and indeed, any
software development; the authors of ntpd comes in mind here) should
have a 386 with 4MB of RAM and some 16MB of swap. Nowadays I have the
luxury of a 486 with 8MB of RAM and 32MB of swap as a firewall, but it's
still a pain to work with.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
