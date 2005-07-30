Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbVG3VDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbVG3VDy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbVG3VDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:03:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62216 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262717AbVG3VDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:03:53 -0400
Date: Sat, 30 Jul 2005 22:03:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>, Arjan Van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>
Cc: Mark Underwood <basicmark@yahoo.com>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ucb1x00: touchscreen cleanups
Message-ID: <20050730220340.K26592@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Arjan Van de Ven <arjanv@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mark Underwood <basicmark@yahoo.com>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20050730102236.B9652@flint.arm.linux.org.uk> <20050730113350.62722.qmail@web30304.mail.mud.yahoo.com> <20050730212820.G26592@flint.arm.linux.org.uk> <20050730204658.GC9418@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050730204658.GC9418@elf.ucw.cz>; from pavel@ucw.cz on Sat, Jul 30, 2005 at 10:46:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 10:46:58PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > Note that I'm maintaining the code and will be
> > > > publishing a new set
> > > > of patches for it based upon Pavel's fixes.
> > > 
> > > Thanks. I'll check them out then.
> > 
> > Since there appears to be some interest in these, I'll set about
> > converting the audio bits to ALSA rather than Nico's SA11x0 audio
> > driver.  I thought no one was using these chips anymore, and the
> > driver was dead!
> > 
> > I've recently edited the mcp structure which may make things less
> > awkward for others, and I'll continue moving in that direction
> > with this driver.
> > 
> > You can get the updated patches at:
> > 
> > 	http://zeniv.linux.org.uk/pub/people/rmk/ucb/
> 
> Okay, what's the plan with mainstreaming those? Do they stay in
> drivers/misc?

Let me put the second question a slightly different way: can anyone
think of a better way to organise the files which makes more sense
and doesn't end up with just a couple of files for the core UCB
and MCP support in some random directory elsewhere?

Arjan?  hch?  any comments / good ideas?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
