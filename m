Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270755AbTGNUAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270772AbTGNUAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:00:14 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:35985 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270755AbTGNT5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:57:14 -0400
Date: Mon, 14 Jul 2003 22:11:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] fbdev and power management
Message-ID: <20030714201143.GE902@elf.ucw.cz>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org> <1057750557.514.22.camel@gaston> <20030709151032.A22612@flint.arm.linux.org.uk> <20020105111340.GA2254@zaurus.ucw.cz> <1058200445.515.23.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058200445.515.23.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm slightly concerned by this.  There are a growing amount of drivers
> > > in 2.5 which are being made to work with the existing power management
> > > system.  This "new" system seems to have been hanging around for about
> > > 4 months now with no visible further work, presumably so that a paper
> > > can be presented before its release.
> > 
> > I believe it is bad idea to change driver
> > model again in 2.6.x-pre. I believe current
> > solution is pretty much okay.
> 
> Current solution is not okay and actually, the save_state/suspend
> distinction makes no sense. 
> We have designed a working solution
> a while ago now, Patrick has it implemented for month, it must
> get in now or 2.6 will not have proper power management but just
> "might work" kind of crap

save_state/suspend distinction may be irrelevant, but I don't see how
it makes whole current code "might work" kind of crap.

Can you describe some significant problem with current code? I do not
think it is good idea to have to touch all drivers in 2.6.0-test time
without some *good* reason.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
