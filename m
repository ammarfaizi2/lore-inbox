Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbTHaVTK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbTHaVTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 17:19:10 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:39885 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262699AbTHaVTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 17:19:07 -0400
Date: Sun, 31 Aug 2003 14:18:55 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bandwidth for bkbits.net (good news)
Message-ID: <20030831211855.GB12752@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pascal Schmidt <der.eremit@email.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030831013928.GN24409@dualathlon.random> <20030831025659.GA18767@work.bitmover.com> <1062335711.31351.44.camel@dhcp23.swansea.linux.org.uk> <20030831144505.GS24409@dualathlon.random> <1062343891.10323.12.camel@dhcp23.swansea.linux.org.uk> <20030831154450.GV24409@dualathlon.random> <20030831162243.GC18767@work.bitmover.com> <20030831163350.GY24409@dualathlon.random> <20030831164802.GA12752@work.bitmover.com> <20030831170633.GA24409@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831170633.GA24409@dualathlon.random>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 07:06:33PM +0200, Andrea Arcangeli wrote:
> On Sun, Aug 31, 2003 at 09:48:02AM -0700, Larry McVoy wrote:
> > works when we've tried what you said to try isn't very compelling.  I know
> > this doesn't work from both theory and practice.
> 
> Post your configure scripts so we can point you what you did wrong.

They are Cisco configuration, it won't do you much good.  All the traffic
goes in/out through a Cisco 2610, we have a full T1 and we clamped all 
TCP traffic at .75Mbit.  Still didn't help even though we verified that
it was indeed clamping down on the traffic.

I'm not sure why you are arguing this, if you have a fat pipe feeding into
a small pipe and you are trying to throttle at far end of the small pipe
isn't it obvious that you can't make that work?  It's not the packets we
send, it's the packets you send.  And all the flow control stuff is per
connection, not per pipe.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
