Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269321AbUJWFKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbUJWFKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUJWFHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:07:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:25295 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269297AbUJWFGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 01:06:25 -0400
Date: Fri, 22 Oct 2004 22:04:39 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Willy Tarreau <willy@w.ods.org>, espenfjo@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041023050439.GA11484@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <7aaed09104102213032c0d7415@mail.gmail.com> <7aaed09104102214521e90c27c@mail.gmail.com> <20041022225703.GJ19761@alpha.home.local> <20041023014004.GG22558@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023014004.GG22558@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 03:40:04AM +0200, Adrian Bunk wrote:
> On Sat, Oct 23, 2004 at 12:57:03AM +0200, Willy Tarreau wrote:
> > On Fri, Oct 22, 2004 at 11:52:50PM +0200, Espen Fjellv?r Olsen wrote:
> >...
> > > A 2.7 should be created where all new experimental stuff is merged
> > > into it, and where people could begin to think new again.
> > 
> > This could be true if the release cycle was shorter. But once 2.7 comes
> > out, many developpers will only focus on their development and not on
> > stabilizing 2.6 as much as today.
> 
> 2.6.9 -> 2.6.10-rc1:
> - 4 days
> - > 15 MB patches
> 
> It's a bit optimistic to call this amount of change "stabilizing".
> 
> 2.6 is corrently more a development kernel than a stable kernel.
> 
> The last bug I observed personally was the problem with suspending when 
> using CONFIG_REGPARM=y together with Roland's waitid patch which was 
> added in 2.6.9-rc2. If I'd used 2.6.9 with the same .config as 2.6.8.1, 
> this was simple one more bug...
> 
> IMHO Andrew+Linus should open a short-living 2.7 tree soon and Andrew 
> (or someone else) should maintain a 2.6 tree with less changes (like 
> Marcelo did and does with 2.4).

I don't ever want to plug anything I've written, but please see the
current issue of Linux Journal with an article explaining how this is
all working, why we are doing this, and how the hell we can keep sane
this way.  I've also got slides on my website from the talk I've given
about this topic at OLS, OSCON, and SUCON about this topic.

In about a month or so, I'll be able to put the linux journal article up
on the web for everyone to see, need to let the publication restriction
expire first...

thanks,

greg k-h
