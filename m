Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbTHaPjG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTHaPjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:39:06 -0400
Received: from [213.39.233.138] ([213.39.233.138]:9695 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262102AbTHaPjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:39:03 -0400
Date: Sun, 31 Aug 2003 17:38:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831153839.GC30196@wohnheim.fh-wedel.de>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030831144505.GS24409@dualathlon.random>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 August 2003 16:45:05 +0200, Andrea Arcangeli wrote:
> On Sun, Aug 31, 2003 at 02:15:12PM +0100, Alan Cox wrote:
> > On Sul, 2003-08-31 at 03:56, Larry McVoy wrote:
> > > I'm pretty convinced we can't solve the problem at our end.  Maybe we can
> > 
> > For bursts of traffic you can't.
> 
> what's the difference of rejecting packets in software, or because the
> link can't handle them?

Nothing, packets are always rejected in software. :)

> it works flawlessy for me and it's the same problem (I also use
> streaming services), and they're unusable until I turn the shaping on,
> I'm sure that if you use the script and you change 1kbyte/sec to
> everything but voip it'll work fine for you too, since basically
> everything else won't pass anymore, it will take ages to open an html
> page and all the bkbits.net users will hang, and the link will be idle
> 99% of the time, so voip will take it over as much as it can. I don't
> think it's a matter of "if it works or not", I think it's a matter of
> how much you're ok to lose in terms of global bandwith for all the other
> services but voip.

Yes, that should work for well behaved traffic.  You have to leave
more breathing room compared to your provider doing the traffic
shaping for you, but it is also more flexible than one line for each
VOIP and the rest.

Still, I don't like the idea of throwing away those packets that have
made it through the bottleneck. :)

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown
