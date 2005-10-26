Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbVJZNUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbVJZNUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 09:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbVJZNUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 09:20:07 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:30732 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751492AbVJZNUF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 09:20:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fZJ2wrKud66pU/rS12Xo4a2i7h86x3KPxy4zaQOPO5c/DzG5VPfHG3cYuQK/rU/Xbk//ItUxlNO4XpPDyQqBVkqgCuS7cG+iDvCMcRr4D6D3nBKVJph+KVYPTdYRoXgV5cLtGqAWzj6q1GxUXI+vJGdnxb1KQ6VgajYKviu9A1M=
Message-ID: <5a4c581d0510260620o1a6ad678v6966dba3f40e8601@mail.gmail.com>
Date: Wed, 26 Oct 2005 15:20:04 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: X unkillable in R state sometimes on startx , /proc/sysrq-trigger T output attached
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970510260528k37cffb12h24d7b6fad7f3ed6e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0510251335ke8e7ae6n883e0b44a9920ce4@mail.gmail.com>
	 <21d7e9970510260325o2a47e6f5gc64d29eec42de086@mail.gmail.com>
	 <5a4c581d0510260522h3c98d1acsf4715a4d4865121c@mail.gmail.com>
	 <21d7e9970510260528k37cffb12h24d7b6fad7f3ed6e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > > > Box is a Dell Latitude C640 laptop, PIV@1.8Ghz,
> > > >  1GB RAM, with a USR2210 802.11b wireless
> > > >  PC Card; video card is a Radeon 7500 M7 LW.
> > > >
> > >
> > > Your getting an X hang which is usually a DRM/AGP or X configuartion problems..
> > >
> > > Please send me your /etc/X11/xorg.conf and /var/log/Xorg.0.log after a hang..
> > >
> > > did it work with any kernel before? and suddenly break recently?
> >
> > It's intermittent. It looks like more recent kernels have a tendency
> >  to trigger it more easily - in fact I just happened to have another
> >  occurrence, this time without even loading the acx driver, just
> >
> >  1. boot
> >  2. login as non-root
> >  3. startx
> >
> >  but it works most times.
> >
> > I lied however - the keyboard is _not_ dead, despite not lighting
> >  the CapsLock led, and I can Alt-SysRQ-<x>.
> >
> > Luckily, I have both the current working Xorg.0.log and the one
> >  coming from the hang. I'm attaching both, and my xorg.conf.
> >
>
> Wierd it all looks okay to me (diffing the Xorg logs gives nothing
> majorly different...)...
>
> What desktop are you runnig on top of X? does it have any 3D or OpenGL
> components in it?

Desktop is FC4 gnome-desktop-2.10.0-5. I don't think I have
 anything fancy in it, apart from the mini-icons on the top panel
 which include oldies (Evolution, Mozilla) and actually used
 stuff (Firefox, gnome-terminal, Thunderbird, Gaim, and the
 volume control).

> if you just run X, does it always start to the X cursor without hanging..

Will try. Note however, when I experience the problem X doesn't
 really "hang" - it spins in CPU.

> Try disabling pre-empt also.. if you get a chance..

Will also build no-preempt kernels in the near future.

> I've got the same chip on an evaluation card in my PC at the moment,
> and I've been running the same X 6.8.2 on it for a while with no
> issues on the latest kernels..

For that matter, I'm running it now without issues... it
 seems to get in the weird state only on startup.

Thanks ! Ciao,

--alessandro

 "All it takes is one decision
  A lot of guts, a little vision to wave
  Your worries, and cares goodbye"

   (Placebo - "Slave To The Wage")
