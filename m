Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbTIETG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265731AbTIETG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:06:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28084 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265729AbTIETGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:06:55 -0400
Date: Fri, 5 Sep 2003 21:06:49 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Patrick Mochel <mochel@osdl.org>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030905190649.GP16859@atrey.karlin.mff.cuni.cz>
References: <200309050158.36447.rob@landley.net> <Pine.LNX.4.44.0309051044470.17174-100000@cherise> <20030905180248.GB29353@gtf.org> <200309051457.37241.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309051457.37241.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > the power LED still on and the hibernate light off, and the thing's a
> > > > brick at that point; the only thing you can do is hold the power button
> > > > down for ten seconds or pop the battery to get it to boot back up from
> > > > scratch.)  So I have to shut the sucker down every time I want to move
> > > > it, which is a pain...
> > >
> > > What model is it? It probably doesn't support APM at all. I can't
> > > guarantee that ACPI suspend/resume will work on it, but I'm interested to
> > > see if it does..
> >
> > Note that a lot of ThinkPads out in the field need a BIOS update
> > before their ACPI is working.  (I know this because IBM was quite
> > helpful and proactive in addressing their Linux-related ACPI BIOS
> > issues)
> 
> ACPI currently works fine in terms of IRQ routing, sensing when the lid closes 
> and the power button gets pressed, telling me how much battery power is left 
> and when I disconnect the AC adapter from the wall...
> 
> I was hoping software suspend would avoid having to have IBM firmware involved 
> in the suspend process at all (it can boot, it can shut down, I just want it 
> to snapshot process state so it comes up with the same things up on the 
> desktop as last time).

Yes software suspend can do that.

> P.S.  I reeeeeeeeeeeeeeeeeally hate it the way the keys on the keyboard 
> sometimes have an up event delayed (or miss it entirely) and decide to 
> auto-repeat insanely fast.  It happens about twice an hour.  I've seen mouse 
> clicks do it as well.  Not a show-stopper, just annoying.

I guess that *is* showstopper. Unfortunately notebook keyboards tend
to be crappy :-(.
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
