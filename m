Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTHaQs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 12:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTHaQsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 12:48:25 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:46281 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262425AbTHaQsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 12:48:23 -0400
Date: Sun, 31 Aug 2003 09:48:02 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831164802.GA12752@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030830230701.GA25845@work.bitmover.com> <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local> <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831163350.GY24409@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 06:33:50PM +0200, Andrea Arcangeli wrote:
> On Sun, Aug 31, 2003 at 09:22:43AM -0700, Larry McVoy wrote:
> > On Sun, Aug 31, 2003 at 05:44:50PM +0200, Andrea Arcangeli wrote:
> > > > It doesn't work when you dont control incoming. As a simple extreme
> > > > example if I pingflood you from a fast site then no amount of shaping
> > > > your end of the link will help, it has to be shaped at the ISP end.
> > > 
> > > sure, that's why I said it won't work with synflood. 
> > 
> > Someone syncs w/ bkbits every 19 seconds 24x7.  We also run our web server
> 
> 1 syn every 19 seconds is nothing.

A sync != one connection.  And that doesn't include the auto backup that we
do to another server, doesn't include all the HTTP traffic, doesn't include
our web site traffic.

> > You guys who are saying it can work are thinking (a) one connection of 
> > long duration (think about all the web hits on bkbits.net, those are all
> 
> it doesn't need to be long duration, just longer than a syn or a ping.
> If it goes in established for a few packets is should be enough to
> throttle it just fine.

You are welcome to *demonstrate* something that works but telling me that it
works when we've tried what you said to try isn't very compelling.  I know
this doesn't work from both theory and practice.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
