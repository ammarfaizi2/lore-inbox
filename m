Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTHaWtS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbTHaWtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:49:18 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57822
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263024AbTHaWtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:49:12 -0400
Date: Mon, 1 Sep 2003 00:49:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831224938.GC24409@dualathlon.random>
References: <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831211855.GB12752@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 02:18:55PM -0700, Larry McVoy wrote:
> On Sun, Aug 31, 2003 at 07:06:33PM +0200, Andrea Arcangeli wrote:
> > On Sun, Aug 31, 2003 at 09:48:02AM -0700, Larry McVoy wrote:
> > > works when we've tried what you said to try isn't very compelling.  I know
> > > this doesn't work from both theory and practice.
> > 
> > Post your configure scripts so we can point you what you did wrong.
> 
> They are Cisco configuration, it won't do you much good.  All the traffic

I don't trust anything but the sourcecode I can read, so please try
again with linux.

> I'm not sure why you are arguing this, if you have a fat pipe feeding into

you never tried with linux, how can you claim you know it doesn't work
in practice? The fact is that you never tried it, while we used it all
the time.

> a small pipe and you are trying to throttle at far end of the small pipe
> isn't it obvious that you can't make that work?  It's not the packets we
> send, it's the packets you send.  And all the flow control stuff is per

it's tcp, it's trivial to rate limit the packets we send, as far as you
go into established somehow.

Andrea
