Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTHaQge (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262466AbTHaQge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:36:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64211
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262465AbTHaQg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:36:28 -0400
Date: Sun, 31 Aug 2003 18:36:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831163651.GZ24409@dualathlon.random>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831162337.GD18767@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831162337.GD18767@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 09:23:37AM -0700, Larry McVoy wrote:
> On Sun, Aug 31, 2003 at 04:31:32PM +0100, Alan Cox wrote:
> > > what's the difference of rejecting packets in software, or because the
> > > link can't handle them? Assume the guaranteed bandwidth is much lower
> > 
> > It doesn't work when you dont control incoming. As a simple extreme
> > example if I pingflood you from a fast site then no amount of shaping
> > your end of the link will help, it has to be shaped at the ISP end.
> 
> HTTP traffic is enough to simulate this, the connections are all small,
> short lived, and there are a lot of them.

it's much harder to throttle http, but it should work too. you may need
bigger margin due the higher percentage of unthrottable packets like
syns.

Andrea
