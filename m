Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288625AbSADNjb>; Fri, 4 Jan 2002 08:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288626AbSADNjP>; Fri, 4 Jan 2002 08:39:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28008 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288625AbSADNie>; Fri, 4 Jan 2002 08:38:34 -0500
Date: Fri, 4 Jan 2002 14:39:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Lang <david.lang@digitalinsight.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dieter Nutzel <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Message-ID: <20020104143901.K1561@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0201041242500.2247-100000@localhost.localdomain> <Pine.LNX.4.40.0201040330460.7718-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.40.0201040330460.7718-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Fri, Jan 04, 2002 at 03:33:19AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 03:33:19AM -0800, David Lang wrote:
> On Fri, 4 Jan 2002, Ingo Molnar wrote:
> 
> > On Fri, 4 Jan 2002, David Lang wrote:
> >
> > > Ingo,
> > > back in the 2.4.4-2.4.5 days when we experimented with the
> > > child-runs-first scheduling patch we ran into quite a few programs that
> > > died or locked up due to this. (I had a couple myself and heard of others)
> >
> > hm, Andrea said that the only serious issue was in the sysvinit code,
> > which should be fixed in any recent distro. Andrea?
> >
> 
> I remember running into problems with some user apps (not lockups, but the
> apps failed) on my 2x400MHz pentium box. I specificly remember the Citrix
> client hanging, but I think there were others as well.

those are broken apps that have to be fixed, they will eventually lockup
even without the patch. userspace can be preempted anytime.

> I'll try and get a chance to try your patch in the next couple days.
> 
> David Lang
> 
> 
>  > > try switching this back to the current behaviour and
> see if the > > lockups still happen.
> >
> > there must be some other bug as well, the child-runs-first scheduling can
> > cause lockups, but it shouldnt cause oopes.
> >
> > 	Ingo
> >


Andrea
