Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283072AbRK1Pt0>; Wed, 28 Nov 2001 10:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283075AbRK1PtU>; Wed, 28 Nov 2001 10:49:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1165 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S283072AbRK1PtH>; Wed, 28 Nov 2001 10:49:07 -0500
Date: Wed, 28 Nov 2001 10:48:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Eric Weigle <ehw@lanl.gov>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Magic Lantern
In-Reply-To: <20011128081305.I22767@lanl.gov>
Message-ID: <Pine.LNX.3.95.1011128102906.15350A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2001, Eric Weigle wrote:

> > > "Richard B. Johnson" <root@chaos.analogic.com> writes:
> > > > Are there currently any kernel hooks to support Magic Lantern?
> > > > Basically, a "tee" to capture all network packets and pass them
> > > > on to a filtering task without affecting normal network activity.
> > > > It's like `tcpdump`, but allows packets to be inserted into the
> > > > output queue as well without affecting normal network activity.
> > > 
> > > The af_packet module can read and write raw ethernet frames.
> The af_packet module may also be fairly inefficient. If you need performance
> over, say, a gigabit link, you may have trouble. I last used it one of the
> earlier 2.4 series (2.4.8 I think) with the Acenic Tigon II gigE copper
> cards to implement a network flooder; At that time a simple unoptimized loop
> sending raw ethernet packets maxed out at at around 80Mbps, while the same loop
> sending UDP packets maxed out at around 400. This may have been fixed by now,
> I don't know... Just a warning.
> 
> -Eric

Okay. I don't think that performance will be a problem in the near
future. As you no doubt know, the DOJ is "requiring" that these
taps be inserted into Operating Systems so that they can access
computers, of course always in direct correspondence with a
wiretap order (if you believe that, I've got a bridge to sell).

Information is that part of M$ agreement with DOJ was to insert
these taps into their OS. In due course, we will have to counter
this by emulation, i.e., always return a nice new, never touched
distribution disk when queried for a directory <grin>, but
presently, if there are "hooks" for "future enhancements", the
DOJ can't refuse to allow the sale or distribution of an OS
as is now proposed.

Once the DOJ actually reads the Constitution, this problem may
go away altogether, but presently the knee-jerk reaction from 9/11
is to violate everybody's computers!

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


