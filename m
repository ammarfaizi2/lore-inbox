Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTHaPnP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTHaPnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:43:15 -0400
Received: from [213.39.233.138] ([213.39.233.138]:29919 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262271AbTHaPnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:43:09 -0400
Date: Sun, 31 Aug 2003 17:43:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831154301.GD30196@wohnheim.fh-wedel.de>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 August 2003 16:31:32 +0100, Alan Cox wrote:
> On Sul, 2003-08-31 at 15:45, Andrea Arcangeli wrote:
> > On Sun, Aug 31, 2003 at 02:15:12PM +0100, Alan Cox wrote:
> > > On Sul, 2003-08-31 at 03:56, Larry McVoy wrote:
> > > > I'm pretty convinced we can't solve the problem at our end.  Maybe we can
> > > 
> > > For bursts of traffic you can't.
> > 
> > what's the difference of rejecting packets in software, or because the
> > link can't handle them? Assume the guaranteed bandwidth is much lower
> 
> It doesn't work when you dont control incoming. As a simple extreme
> example if I pingflood you from a fast site then no amount of shaping
> your end of the link will help, it has to be shaped at the ISP end.

If someone wants to DOS you, he can.  Full stop.

iirc, Larry was worried about well behaved traffic still doing bad
things to his connection.

Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
