Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTKSAtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 19:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTKSAtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 19:49:10 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:25733 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263778AbTKSAtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 19:49:06 -0500
Date: Tue, 18 Nov 2003 16:49:01 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: Larry McVoy <lm@bitmover.com>, Ben Collins <bcollins@debian.org>,
       Sven Dowideit <svenud@ozemail.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031119004901.GA5070@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Walrond <andrew@walrond.org>, Larry McVoy <lm@bitmover.com>,
	Ben Collins <bcollins@debian.org>,
	Sven Dowideit <svenud@ozemail.com.au>, linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <20031118183058.GS476@phunnypharm.org> <20031118184200.GA13966@work.bitmover.com> <200311190024.51548.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311190024.51548.andrew@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 12:24:51AM +0000, Andrew Walrond wrote:
> On Tuesday 18 Nov 2003 6:42 pm, Larry McVoy wrote:
> > I'm curious as to why you would think this is better than the CVS gateway.
> > The CVS gateway is actually a really nice thing.  The whiners think we
> > have somehow hamstrung the data in the gateway but that's only because
> > they haven't looked at the data, if they had done a careful comparison
> > then they'd know it's all in there.
> 
> Since you've already done all the work for bk2cvs, why not add the 
> functionality to bkd which would allow a simple client to do
> 
> 	lobobk cvsclone
> and
> 	lobobk cvspull

Because the translation process is hugely CPU intensive.  It takes
something like 6 hours to do the 2.5 tree on 2.2Ghz Athlon with a gig
of ram.  And it uses every bit of that ram, that's my desktop machine
and _everything_ is paged out when I come in in the morning.

I agreed to the BK2CVS stuff as a way of ensuring that people had the
data in a format that they could use without BK and was useful.  I'm
willing to do that for each main tree of each major project (i.e., if
XFree86 or something like that moved to BK we'd agree to do the CVS
conversion so that there was no lockin).

But doing it for every branch of every tree is nuts unless you are 
donating a 16 way with a zillion gigs of ram.  And a zillion disk
arms, this thrashes the heck out of the disk.

> And when you've finished that, I'd like a moon rocket please. GPL, of 
> course ;)

Yeah, and I'd like all the open source developers of the world to acknowledge
that I'm a good guy and I'm trying to help.  In writing, of course ;)
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
