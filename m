Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263042AbTHaW4w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTHaW4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:56:52 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:4303 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S263042AbTHaW4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:56:47 -0400
Date: Sun, 31 Aug 2003 15:56:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831225639.GB16620@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random> <20030831211855.GB12752@work.bitmover.com> <20030831224938.GC24409@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831224938.GC24409@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 12:49:38AM +0200, Andrea Arcangeli wrote:
> > They are Cisco configuration, it won't do you much good.  All the traffic
> 
> I don't trust anything but the sourcecode I can read, so please try
> again with linux.

We did that as well.  We ran wondershaper on bkbits.net AND capped the 
Cisco.

> > I'm not sure why you are arguing this, if you have a fat pipe feeding into
> 
> you never tried with linux, how can you claim you know it doesn't work
> in practice? The fact is that you never tried it, while we used it all
> the time.

Not for VOIP with a busy server you don't.

> > a small pipe and you are trying to throttle at far end of the small pipe
> > isn't it obvious that you can't make that work?  It's not the packets we
> > send, it's the packets you send.  And all the flow control stuff is per
> 
> it's tcp, it's trivial to rate limit the packets we send, as far as you
> go into established somehow.

Let's see.  We've tried Linux.  It didn't work.  We tried again w/ the 
Cisco.  Didn't work.  Tried with both.  Didn't work.  Stopped hacking
and starting thinking and realized it's impossible to make it work at
just one end, especially at the wrong end.  Several people who I trust
(like Alan for example) pointed it that the theory matches the practice,
it can't work.

Yet you keep insisting it will work.  Why?  What is the theory that says
you can keep the other end of the T1 line from being congested when you
don't have control over that router?  And that router has several 100Mbit
links all of which can point at my 1.5Mbit link.  Explain to me how anything
you do can make that work.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
