Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290543AbSA3USR>; Wed, 30 Jan 2002 15:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290541AbSA3USH>; Wed, 30 Jan 2002 15:18:07 -0500
Received: from bitmover.com ([192.132.92.2]:425 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290539AbSA3URx>;
	Wed, 30 Jan 2002 15:17:53 -0500
Date: Wed, 30 Jan 2002 12:17:52 -0800
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, Jeff Garzik <garzik@havoc.gtf.org>,
        Rob Landley <landley@trommello.org>,
        Miles Lane <miles@megapathdsl.net>, Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130121752.B21235@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Rob Landley <landley@trommello.org>,
	Miles Lane <miles@megapathdsl.net>,
	Chris Ricker <kaboom@gatech.edu>,
	World Domination Now! <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130080642.E18381@work.bitmover.com> <Pine.LNX.4.33.0201301830320.9003-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0201301830320.9003-100000@serv>; from zippel@linux-m68k.org on Wed, Jan 30, 2002 at 09:06:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:06:17PM +0100, Roman Zippel wrote:
> > > What we IMO need is a patch management system
> > > not a source management system.
> >
> > BK can happily be used as a patch management system and it can, and has
> > for years, been able to accept and generate traditional patches.  Linus
> > could maintain the source in a BK tree and make it available as both
> > a BK tree and traditional patches.
> 
> It's not really the same or that's not what I mean with patch management
> system or can bk also manage the patches, which Linus drops?
> What I have in mind is a patch management system which tracks the status
> of unapplied patches. The status could be:
> - patch applies cleanly to tree x.
> - patch is approved/disappoved by y.
> - patch is in tree z since version...

Yeah, I think BK can do this, most of what you are describing is covered
by already existing BK commands and practices.  There are literally dozens
of different sites using BK to track the kernel and both internal and
external sources of patches.  I'm sure there are issues that need to be
resolved and we'll try to do so.  

I might be mistaken, I also get the feeling that your real issue might
be that you don't like/understand/something BK and you are pushing for a
different answer.  That's cool, there are now two patchbot projects you
can go join and start coding.  Some of our biggest fans are people who
have tried that and discovered exactly how complex the problem space
really is, so it's actually in my best interest to encourage you to
go help out with one of those projects.  If you solve the problem, the
kernel benefits and I get to learn something: that's good.  Or you don't
and you'll come to respect BK: that's good too, at least I like it.

So have some fun, this is actually a more challenging area than any
kernel work I've ever done or seen, including SMP threading, so the more
you get into it, the more fun you can have (assuming that banging your
brain against some hard problems meets your fun definition).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
