Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbTHaPcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 11:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTHaPcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 11:32:25 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:15037 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262210AbTHaPcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 11:32:23 -0400
Subject: Re: bandwidth for bkbits.net (good news)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@bitmover.com>, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030831144505.GS24409@dualathlon.random>
References: <20030830230701.GA25845@work.bitmover.com>
	 <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local>
	 <20030831013928.GN24409@dualathlon.random>
	 <20030831025659.GA18767@work.bitmover.com>
	 <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk>
	 <20030831144505.GS24409@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 16:31:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 15:45, Andrea Arcangeli wrote:
> On Sun, Aug 31, 2003 at 02:15:12PM +0100, Alan Cox wrote:
> > On Sul, 2003-08-31 at 03:56, Larry McVoy wrote:
> > > I'm pretty convinced we can't solve the problem at our end.  Maybe we can
> > 
> > For bursts of traffic you can't.
> 
> what's the difference of rejecting packets in software, or because the
> link can't handle them? Assume the guaranteed bandwidth is much lower


It doesn't work when you dont control incoming. As a simple extreme
example if I pingflood you from a fast site then no amount of shaping
your end of the link will help, it has to be shaped at the ISP end.

