Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272225AbTHRSHZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHRSHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:07:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53678
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272225AbTHRSHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:07:24 -0400
Date: Mon, 18 Aug 2003 17:06:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Oleg Drokin <green@namesys.com>, marcelo@conectiva.com.br, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030818150625.GW7862@dualathlon.random>
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com> <20030813153009.GA27209@namesys.com> <20030813180405.3c45465d.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813180405.3c45465d.skraw@ithnet.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 06:04:05PM +0200, Stephan von Krawczynski wrote:
> On Wed, 13 Aug 2003 19:30:09 +0400
> Oleg Drokin <green@namesys.com> wrote:
> 
> > Hello!
> > 
> > On Wed, Aug 13, 2003 at 05:12:24PM +0200, Stephan von Krawczynski wrote:
> > 
> > > Well, that's exactly the reason why I am awaiting some more days of
> > > up-and-running ext3. After how many days will you be convinced that a
> > > random memory corruption should have hit the ext3 system that bad, that it
> > > should have crashed?
> > 
> > Well, I'd prefer that you spend time to figure out at which exact
> > 2.4.21-pre version the crashes in reiserfs started to appear. ;)
> 
> Well, Oleg, I'd love to, but there is an immanent problem with that. If
> I check pre-X and it crashes, everything is fine, because I have a certain
> result of the test. If it does not crash within 3 days, then I have a problem.
> How long do I wait before stating the pre is good? It could take months to test
> 10 pre's ... That cannot be the way to find out what is going on. 
> On the other hand: 
> - no UP kernel ever crashed. So we can at least talk about an SMP-race.
> - 2.4.20 does not crash
> - 2.4.21 does crash

an SMP kernel puts the double of the stress on the mem bus, so it might
still be ram that went bad around the time you upgraded from 2.4.19. Or
it maybe simply a buggy smp motherboard, or whatever.

Of course I can't be sure but we can't exclude it.

Andrea
