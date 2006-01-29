Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWA2FfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWA2FfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 00:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWA2FfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 00:35:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:47851 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750828AbWA2FfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 00:35:24 -0500
Date: Sat, 28 Jan 2006 21:34:58 -0800
From: Greg KH <gregkh@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Chuck Wolber <chuckw@quantumlinux.com>, jmforbes@linuxtx.org,
       linux-kernel@vger.kernel.org, stable@kernel.org, zwane@arm.linux.org.uk,
       tytso@mit.edu, davej@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
Message-ID: <20060129053458.GA9293@suse.de>
References: <20060128021749.GA10362@kroah.com> <Pine.LNX.4.63.0601282028210.7205@localhost.localdomain> <20060129044307.GA23553@linuxtx.org> <Pine.LNX.4.63.0601282048380.7205@localhost.localdomain> <20060128205701.5b84922e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128205701.5b84922e.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 08:57:01PM -0800, Randy.Dunlap wrote:
> On Sat, 28 Jan 2006 20:52:46 -0800 (PST) Chuck Wolber wrote:
> 
> > On Sat, 28 Jan 2006, Justin M. Forbes wrote:
> > 
> > > On Sat, Jan 28, 2006 at 08:30:25PM -0800, Chuck Wolber wrote:
> > > > 
> > > > Please correct me if I'm wrong here, but aren't we supposed to stop doing 
> > > > this for the 2.6.14 release now that 2.6.15 is out?
> > >
> > > I don't see a problems with doing additional stable releases for any 
> > > kernel, I just wouldn't commit to supporting any specific number of 
> > > releases.  Basically if people send enough patches to warrant a 
> > > review/release there is obviously some interest.  What is the harm?
> > 
> > The harm is that stable release patches will eventually start being 
> > maintained and we'll have to add another stable release "dot" to the end 
> > of the growing width of the release version moniker. This stable branch 
> > was meant only for "one-off" fixes to a stable release, not for adding 
> > fixes upon fixes upon fixes that eventually turn into features that have 
> > to be maintained. A new stable release means we change our focus to it and 
> > ignore the old stable release.
> 
> It's a 6-month sliding window for stable releases IIRC.
> Maybe <stable@kernel.org> can add something like that to
> Documentation/stable_kernel_rules.txt>.

No, it's not a 6 month window, I released this because people sent us
patches that they said should go into the 2.6.14-stable tree.  And as
people complained so much on lkml that we were dropping the old kernels
too fast, I never thought that people would complain that we are
maintaining older stuff that people seem interested in...

And, odds are, it will probably be the last 2.6.14 stable kernel we (the
stable team) release, unless something unusual happens...

And, as always, anyone is free to take on maintaining any of the
different kernel versions for as long as they wish.

Does that help?

Man, people complain when you don't maintain older kernels, and they
complain when you do...

thanks,

greg k-h
