Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272575AbTHOTO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272577AbTHOTO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:14:59 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:51412 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S272575AbTHOTO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:14:58 -0400
Date: Fri, 15 Aug 2003 23:15:13 +0200
From: Clock <clock@twibright.com>
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nforce2 lockups
Message-ID: <20030815231513.A5681@beton.cybernet.src>
References: <df962fdf9006.df9006df962f@us.army.mil> <200308151738.08965.alistair@devzero.co.uk> <20030815210601.A5452@beton.cybernet.src> <200308151847.20128.alistair@devzero.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308151847.20128.alistair@devzero.co.uk>; from alistair@devzero.co.uk on Fri, Aug 15, 2003 at 06:47:20PM +0100
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 06:47:20PM +0100, Alistair J Strachan wrote:
> On Friday 15 August 2003 20:06, Clock wrote:
> [SNIP]
> >
> > I have had three boards with nforce2 replaced (all of them Soltek
> > SL75FRN2-L) and all three did the same. However it seemed the frequency of
> > the crashes varies with actual piece of board.
> 
> That's certainly interesting.
> 
> >
> > The crashes aren't in software - bare 'cat /dev/hda > /dev/null' is
> > often to lock up the machine to the point that poweroff fails.
> 
> [root] 06:43 PM [/home/alistair] time cat /dev/discs/disc0/disc > /dev/null
> (I ctrl-C'd here)
> 
> real    1m23.275s
> user    0m0.979s
> sys     0m12.608s
> 
> I don't know how obvious the problem is on your machine, but it's clearly not 
> an issue on this nForce2. When I was referring to software, that included the 
> kernel i.e., I suspect it isn't a design fault.

It seems to occur fairly often just after boot time. When you try later,
you usually fail in an attempt to lockup the machine and have to freshly RESET
(not ctrl-alt-del!) the machine to get the behaviour back.

Cl<
