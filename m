Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264015AbTKSKpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 05:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264016AbTKSKpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 05:45:11 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:31908 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S264015AbTKSKpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 05:45:07 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: kernel.bkbits.net off the air
Date: Wed, 19 Nov 2003 10:45:05 +0000
User-Agent: KMail/1.5.4
Cc: Larry McVoy <lm@bitmover.com>, Ben Collins <bcollins@debian.org>,
       Sven Dowideit <svenud@ozemail.com.au>, linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311190024.51548.andrew@walrond.org> <20031119004901.GA5070@work.bitmover.com>
In-Reply-To: <20031119004901.GA5070@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311191045.05474.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry

On Wednesday 19 Nov 2003 12:49 am, Larry McVoy wrote:
>
> Because the translation process is hugely CPU intensive.  It takes
> something like 6 hours to do the 2.5 tree on 2.2Ghz Athlon with a gig
> of ram.  And it uses every bit of that ram, that's my desktop machine
> and _everything_ is paged out when I come in in the morning.

But once you've done it, incoming changesets are then added incrementally, 
right? You don't just convert the tree once a day?

So you'd just need to maintain two copies of the cvs tree, one which currently 
available for coherent transmission to lobobk clients, and the other which 
can be updated, with a means of swapping them

> I agreed to the BK2CVS stuff as a way of ensuring that people had the
> data in a format that they could use without BK and was useful.  I'm
> willing to do that for each main tree of each major project (i.e., if
> XFree86 or something like that moved to BK we'd agree to do the CVS
> conversion so that there was no lockin).

But, as I described in my previous post, it also has at least one useful 
commercial application.

> But doing it for every branch of every tree is nuts unless you are
> donating a 16 way with a zillion gigs of ram.  And a zillion disk
> arms, this thrashes the heck out of the disk.

The 2.5 tree is <300Mb, so just stick 4Gb in your machine, the bk and cvs tree 
in tmpfs and, well, throw the HD away ;)

> > And when you've finished that, I'd like a moon rocket please. GPL, of
> > course ;)

This was in anticipation of somebody calling me a whinging pom. And sure 
enough... (And yes, my antipodean mates, we are going to _stuff_ you on 
saturday!)

> Yeah, and I'd like all the open source developers of the world to
> acknowledge that I'm a good guy and I'm trying to help.  In writing, of
> course ;)

I think everyone who works for a living knows that already :)

