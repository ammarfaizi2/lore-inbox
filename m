Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbTHaQd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTHaQd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:33:28 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39891
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262381AbTHaQd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:33:27 -0400
Date: Sun, 31 Aug 2003 18:33:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831163350.GY24409@dualathlon.random>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831162243.GC18767@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 09:22:43AM -0700, Larry McVoy wrote:
> On Sun, Aug 31, 2003 at 05:44:50PM +0200, Andrea Arcangeli wrote:
> > > It doesn't work when you dont control incoming. As a simple extreme
> > > example if I pingflood you from a fast site then no amount of shaping
> > > your end of the link will help, it has to be shaped at the ISP end.
> > 
> > sure, that's why I said it won't work with synflood. 
> 
> Someone syncs w/ bkbits every 19 seconds 24x7.  We also run our web server

1 syn every 19 seconds is nothing.

> You guys who are saying it can work are thinking (a) one connection of 
> long duration (think about all the web hits on bkbits.net, those are all

it doesn't need to be long duration, just longer than a syn or a ping.
If it goes in established for a few packets is should be enough to
throttle it just fine.

Andrea
