Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWFBJBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWFBJBf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 05:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWFBJBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 05:01:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42145 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751343AbWFBJBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 05:01:34 -0400
Date: Fri, 2 Jun 2006 11:00:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@gmail.com>, Ondrej Zajicek <santiago@mail.cz>,
       "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060602090045.GB25806@elf.ucw.cz>
References: <200605302314.25957.dhazelton@enter.net> <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com> <200605310026.01610.dhazelton@enter.net> <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com> <20060601092807.GA7111@localhost.localdomain> <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com> <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com> <9e4733910606011918vc53bbag4ac5e353a3e5299a@mail.gmail.com> <21d7e9970606011945i57e2cfd2la77459fc7273b6e7@mail.gmail.com> <9e4733910606012027y2567c194yf02a96319fe33e63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910606012027y2567c194yf02a96319fe33e63@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > 15) re-use as much of the X drivers as possible, otherwise it will KGI.
> >>
> >> I would broaden this to use the best code where ever it is found. Of
> >> course X is a major source.
> >
> >I'm not considering using knowledge from X drivers, I'm considering
> >using the X drivers, I don't personally care about things like X's
> >over use of typedefs and that sort of stuff, that is what I term
> >semantic, people who work on X drivers know X drivers, and writing the
> >drivers is the biggest part of any graphic systems.
> 
> I have considered that option too. It is a good place for a quick
> start but it is not maintainable in the long run. The driver code has
> to be divorced from X and not require having the entire X system
> around to build a new driver.
> 
> Have you checked the dependencies needed for loading X drivers?
> Modularization may have helped but loading an X driver used to
> effectively suck in the entire X server due to dependencies. Sucking
> in all of X is not fair to alternative windowing systems.

Why not? For now we can have something that works, and alternative
windowing systems can strip it down if they wish to.

> I do agree that this is a workable starting point but it can't be the
> long term solution.

Long term, someone is definitely going to clean up that userspace
code...

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
