Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263574AbRFFQkK>; Wed, 6 Jun 2001 12:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263575AbRFFQkA>; Wed, 6 Jun 2001 12:40:00 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:2971 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S263574AbRFFQjt>;
	Wed, 6 Jun 2001 12:39:49 -0400
Message-ID: <3B1E64EA.8F4FD7C9@candelatech.com>
Date: Wed, 06 Jun 2001 10:14:18 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
		<991815578.30689.1.camel@nomade>
		<20010606095431.C15199@dev.sportingbet.com>
		<0106061316300A.00553@starship> <200106061528.f56FSKa14465@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> 
> Daniel Phillips writes:
> > On Wednesday 06 June 2001 10:54, Sean Hunter wrote:
> >
> > > > Did you try to put twice as much swap as you have RAM ? (e.g. add a
> > > > 512M swapfile to your box)
> > > > This is what Linus recommended for 2.4 (swap = 2 * RAM), saying
> > > > that anything less won't do any good: 2.4 overallocates swap even
> > > > if it doesn't use it all. So in your case you just have enough swap
> > > > to map your RAM, and nothing to really swap your apps.
> > >
> > > For large memory boxes, this is ridiculous.  Should I have 8GB of
> > > swap?
> 
> Sure. It's cheap. If you don't mind slumming it, go and buy a 20 GB
> IDE drive for US$65. I know RAM has gotten a lot cheaper lately (US$66
> for a 512 MiB PC133 DIMM), but it's still far more expensive. If you
> can afford 4 GiB of RAM, you can definately afford 8 GiB of swap.

For me, the problem is not the money.  If I have a system that needs
4GB of RAM, it is highly unlikely that I would ever want to be running
this machine with 8GB of swap active.  However, I may be willing to
tollerate 1GB of swapping before paging to disk slowed things down
too much.  This is the exact scenario I had when dealing with a large
Sun machine running Oracle & some other stuff.  Oracle is dedicated large
amounts of RAM, but if I wanted to run a quick, memory intensive program
too, (and at the moment performance isn't all that big of a deal), then
using some swap is OK.

So, I too cast my vote for the 2*RAM requiment to be odious and in
need of fixing!!  It could be a suggestion, but I would consider that
if not following the suggestion caused more than 10% slowdown, then
things are still broken, and optimally, it should work like the 2.2
does (in other words, I don't notice, and don't particularly care
how much swap per RAM I need, just how much total RAM-like-stuff I need.)

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
