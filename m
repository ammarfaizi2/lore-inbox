Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292685AbSBUSDR>; Thu, 21 Feb 2002 13:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292683AbSBUSDD>; Thu, 21 Feb 2002 13:03:03 -0500
Received: from boink.boinklabs.com ([162.33.131.250]:49680 "EHLO
	boink.boinklabs.com") by vger.kernel.org with ESMTP
	id <S292687AbSBUSCl>; Thu, 21 Feb 2002 13:02:41 -0500
Date: Thu, 21 Feb 2002 13:02:40 -0500
From: Charlie Wilkinson <cwilkins@boinklabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Hard lock-ups on RH7.2 install - Via Chipset?
Message-ID: <20020221130240.B12456@boink.boinklabs.com>
In-Reply-To: <20020221105756.A9728@boink.boinklabs.com> <E16dw9r-0007R1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E16dw9r-0007R1-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 21, 2002 at 04:33:23PM +0000
X-Home-Sweet-Home: RedHat 6.0 / Linux 2.2.12 on an AMD K6-225
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 04:33:23PM +0000, Alan Cox waxed eloquent:
> 
> > I can confirm that it still locks up.  :/  What can I do to help?
> 
> I'm assuming its a hardware issue. It works on non VIA for multiple people
> it fails on VIA for multiple people

yeah, appears to be specific to the KT133 (not 233), as Mark indicated.
If I recall I've seen reports that this has happened with the KT133A
as well, though I wonder if they are all related specifically to PCI
load, or might it be the old Athlon optimization problem in some cases?
(That was a seperate and distinct issue, generally unrelated to this
problem, yes?)

And then there was something about incorrect chipset register settings
from the BIOS...

I'm getting confused....  8-o

One thing I noticed - and it may mean nothing - but I noticed that
during my load tests the drive access lights were not always on solid,
that the lights went out for all drives for a small fraction of a second
occasionally.  (concurrent dd's from /dev/zero to each drive.)  I was
wondering if this might possibly work back to some kind of timeout issue.
And more importantly, is it possible to crank up debugging messages in
the kernel and watch for that sort of thing.  Is there any point?

Thanks for any tips.

-cw-
