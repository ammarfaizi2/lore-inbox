Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752559AbVHGSyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbVHGSyy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbVHGSyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:54:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59853 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1752559AbVHGSyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:54:52 -0400
Date: Sun, 7 Aug 2005 20:50:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
       dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050807185037.GC1024@openzaurus.ucw.cz>
References: <20050726015401.GA25015@kroah.com> <200508052020.13568.oliver@neukum.org> <9e47339105080511474d89ee8a@mail.gmail.com> <200508052207.49270.oliver@neukum.org> <9e47339105080513335e2674fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105080513335e2674fa@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > If we are going back to needing helper scripts then I should just
> > > remove the entire sysfs graphics interface and switch back to using
> > > ioctls and a helper app. Of could no one can ever find the helper app
> > > or remember how it works. I thought one of the main reasons behind the
> > > sysfs interface was to eliminate these helper apps.
> > 
> > The point is that you _can_ do it with echo, not that it is _easy_.
> > Nor is sysfs a solution in any case.
> > 
> > > Without doing whitespace cleanup there is a 100% probability that this
> > > will generate bug reports. I know this for a fact because I am already
> > > getting them.
> > 
> > Stupid users are not a reason for kernel bloat.
> 
> You have a very wrapped sense of kernel bloat. This is nine lines of
> code whose absence is guaranteed to generate a bunch of bug reports.
> Not having it is also causing various implementers to implement
> attribute processing differently. Some are stripping white space in
> their implementations and some are not. If you want to attack kernel

Can you point place where we do strip whitespace in kernel sysfs handlers?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

