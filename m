Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280000AbRKDPdw>; Sun, 4 Nov 2001 10:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280001AbRKDPdm>; Sun, 4 Nov 2001 10:33:42 -0500
Received: from otter.mbay.net ([206.40.79.2]:27916 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S280000AbRKDPdb>;
	Sun, 4 Nov 2001 10:33:31 -0500
Date: Sun, 4 Nov 2001 07:32:31 -0800 (PST)
From: John Alvord <jalvo@mbay.net>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Thomas Lussnig <tlussnig@bewegungsmelder.de>,
        linux-kernel@vger.kernel.org,
        khttpd mailing list <khttpd-users@zgp.org>,
        Tux mailing list <tux-list@redhat.com>
Subject: Re: [khttpd-users] khttpd vs tux
In-Reply-To: <20011104010703.H23391@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.20.0111040729140.23357-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Nov 2001, Erik Mouw wrote:

> On Sat, Nov 03, 2001 at 08:18:19PM +0100, Roy Sigurd Karlsbakk wrote:
> > > Each GigE card will need its own 66MHz PCI bus. Each PCI bridge will need
> > > to be coming off a memory bus that can sustain all of these and the CPU
> > > at once.
> > >
> > > At that point it really doesnt look much like a PC.
> > 
> > How much raw speed do you think I can manage to get out of a really cool
> > n-way server from Compaq? I beleive we'll go for a Compaq server, as
> > that's what's been decided some time ago.
> 
> Not that much. Alan's point is that you're pushing the limit of the
> memory bandwidth, not the number of CPUs. This is the single reason
> that high traffic websites either use some serious non-PC hardware (IBM
> Z-series, for example) or a large number of PCs in parallel to share
> the load.
> 
> > I read something by Linus about linux scalability, and I beleive he said
> > that 'linux [2.4] scales good up to 4 cpus, but not that good futher on
> > [to 8?]'. Can anyone fill in the holes here?
> 
> The number of CPUs really doesn't matter in this case. With several
> GigE cards memory bandwidth and latency is your main problem.

Interesting parallel...

In the last few years there have been multiple cases where people reported
benchmarks where a dual processir gave less thruput then a single
processor. In most cases, the single processor benchmark had saturated the
memory bandwidth and a second processor didn't make much difference.

This was on "cheap" multi-processors.

john alvord

