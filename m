Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbTIEUfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266053AbTIEUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:32:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52171 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266109AbTIEUb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:31:59 -0400
Date: Fri, 5 Sep 2003 22:31:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Keyboard stuff (was Re: Fix up power managment in 2.6)
Message-ID: <20030905203157.GU16859@atrey.karlin.mff.cuni.cz>
References: <200309050158.36447.rob@landley.net> <200309051457.37241.rob@landley.net> <20030905190649.GP16859@atrey.karlin.mff.cuni.cz> <200309051609.35135.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309051609.35135.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I was hoping software suspend would avoid having to have IBM firmware
> > > involved in the suspend process at all (it can boot, it can shut down, I
> > > just want it to snapshot process state so it comes up with the same
> > > things up on the desktop as last time).
> >
> > Yes software suspend can do that.
> 
> Footnote 1: If it worked, which I've never been able to get it to
> do.

Try -test3 with ext2 and minimal set of drivers.

> > > P.S.  I reeeeeeeeeeeeeeeeeally hate it the way the keys on the keyboard
> > > sometimes have an up event delayed (or miss it entirely) and decide to
> > > auto-repeat insanely fast.  It happens about twice an hour.  I've seen
> > > mouse clicks do it as well.  Not a show-stopper, just annoying.
> >
> > I guess that *is* showstopper. Unfortunately notebook keyboards tend
> > to be crappy :-(.
> 
> Not on a thinkpad.  I could probably bring down a wild caribou with this 
> thing, it's designed like a tank.  (Part of the reason I bought it. :)
> 
> I tried 2.4 for a bit on it when I was first trying to get it working.  
> (Largely to assess how much reconfiguration needed to be done, since I'd 
> swapped in a hard drive from a toshiba and didn't want to have to reinstall.)
> 
> The keyboard never had a problem under 2.4, this is a 2.6 problem.
> It also 

You need to report this to vojtech, I guess.
									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
