Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313392AbSDPP0u>; Tue, 16 Apr 2002 11:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313401AbSDPP0t>; Tue, 16 Apr 2002 11:26:49 -0400
Received: from waste.org ([209.173.204.2]:39860 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S313392AbSDPP0s>;
	Tue, 16 Apr 2002 11:26:48 -0400
Date: Tue, 16 Apr 2002 10:26:24 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <wli@holomorphy.com>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <Pine.LNX.4.44L.0204161156330.1960-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.44.0204161015380.3933-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Rik van Riel wrote:

> On Tue, 16 Apr 2002, Oliver Xymoron wrote:
> > On Mon, 15 Apr 2002, Linus Torvalds wrote:
> > > On Mon, 15 Apr 2002, Linus Torvalds wrote:
> > > >
> > > > Which requires the user to use something like
> > > >
> > > > 	for_each_zone(zone) {
> > > > 		...
> > > > 	} end_zone;
>
> > Ugh. If we're going to use such ugly things, it would be nice if they were
> > do_zone/while_zone instead of being suggestive of a for loop.
>
> Ummm, it _is_ a for loop.

Conceptually, sure, but the underlying macros Linus suggested made it
do/while. As the do/while form is the only control structure in C where we
have something that looks like an expression after a block, naming it for_
seems terribly incongruous. Naming it do_/while_ would make it slightly
less ugly, at least to my eyes, and serve to remind that both parts are
essential.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

