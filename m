Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVHBLYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVHBLYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVHBLYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:24:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59114 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261499AbVHBLXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:23:19 -0400
Date: Tue, 2 Aug 2005 13:23:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: David Weinehall <tao@acc.umu.se>, Lee Revell <rlrevell@joe-job.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050802112304.GA1308@elf.ucw.cz>
References: <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <20050801074447.GJ9841@khan.acc.umu.se> <42EE4B4A.80602@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE4B4A.80602@andrew.cmu.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Any argument along the lines of the change of a default
> >value in the defconfig screwing people over equally applies the other
> >way around; by not changing the defconfig, you're screwing laptop users
> >(and others that want less power consumption) over.  The world is not
> >black and white, it's a very boring gray (or a very sadening bloody
> >red; but I hope we won't come to that point just because of a silly
> >argument on lkml...)
> 
> The tradeoff is a realistic 4.4% power savings vs a 300% increase in the 
> minimum sleep period.  A user will see zero power savings if they have a 
> USB mouse (probably 99% of desktops).  On top of that, we can throw in 
> Con's disturbing AV benchmark results (1).  As a result, some of us 
> don't think 250HZ is a great tradeoff to make
> _for_the_default_value_.

As I said, I do not care about default value. And you should not care,
too, since distros are likely to pick their own defaults.

> From what I can tell, tick skipping works fine right now, it just needs 
> some cleanup.  Thus I'd expect something like it will get integrated 
> into 2.6.14.  If it gets in, the default HZ should go back up to 1000. 
> In that case why decrease it for exactly one patchlevel?

I am afraid that CONFIG_NO_IDLE_HZ will be ready for 2.6.14...

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
