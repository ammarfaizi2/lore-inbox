Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWAEEnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWAEEnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 23:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWAEEnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 23:43:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:60824 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751926AbWAEEnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 23:43:12 -0500
Date: Wed, 4 Jan 2006 20:42:39 -0800
From: Greg KH <greg@kroah.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: userspace breakage
Message-ID: <20060105044239.GA24764@kroah.com>
References: <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org> <20051229230307.GB24452@redhat.com> <20060103202853.GF12617@kroah.com> <20060103203724.GG5819@redhat.com> <4d8e3fd30601041500t20f54dcdpdb6866b7753d1731@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd30601041500t20f54dcdpdb6866b7753d1731@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 12:00:39AM +0100, Paolo Ciarrocchi wrote:
> On 1/3/06, Dave Jones <davej@redhat.com> wrote:
> > On Tue, Jan 03, 2006 at 12:28:53PM -0800, Greg Kroah-Hartman wrote:
> >
> >  > > I'm glad you agree.  I've decided to try something different once 2.6.16
> >  > > is out.  Every day, I'm going to push the -git snapshot of the day into
> >  > > a testing branch for Fedora users. (Normally, only rawhide[1] users
> >  > > get to test kernel-de-jour, and this always has the latest userspace, so
> >  > > we don't notice problems until a kernel point release and the stable
> >  > > distro gets an update).
> >  >
> >  > Ah, nice idea, I'll try to set up the same thing for Gentoo's kernels.
> >  > Hopefully the expanded coverage will help...
> 
> Greg,
> did you manage for doing the same for Gentoo?

As there wasn't a more recent kernel than 2.6.15 until a few hours ago,
no I haven't done this yet :)

> If so, what's the approach? Is Gentoo now shipping pre-compiled -git
> vanilla kernels as well?

Gentoo doesn't ship anything "pre-compiled" :)

Well, ok, I guess it does with the -bin packages...

I was just going to build a -git kernel ebuild and let users update
that.  But maybe I should start building pre-built kernels, I'll take it
to the gentoo-dev list, as this isn't a linux-kernel specific thing.

thanks,

greg k-h
