Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRCAMW3>; Thu, 1 Mar 2001 07:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbRCAMWT>; Thu, 1 Mar 2001 07:22:19 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:772 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S129393AbRCAMWF>;
	Thu, 1 Mar 2001 07:22:05 -0500
Date: Thu, 1 Mar 2001 06:22:01 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 kernels - "attempt to access beyond end of device"
In-Reply-To: <C291BF3C67@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0103010616050.599-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Petr Vandrovec wrote:

> On 28 Feb 01 at 15:47, Michal Jaegermann wrote:
> > > > I have more checks to make before I will be fully satisfied but
> > > > this looks like it.
> > > ...
> > > > System Performance Setting [Optimal, Normal]
> > > ...
> > >
> > > Try BIOS 1006. AFAIK 1005D changed some VIA values for 'optimal'.
> >
> > Is that important here?  IDE drives in question were not connected to
> > on-board controller but the Promise one.  Results seem to indicate
> > that this 'optimal' was important here anyway.
>
> VIA host-bridge, not VIA-IDE... It is important even if you use Promise
> only - look back through archives, there must be something really wrong
> with this motherboard.

I'm beginning to believe it may be BIOS revision related.  I haven't
tried the Promise controller since I don't have an ATA-100 drive, but I
don't seem to have any of the data corruption or other problems that
people have mentioned.  I guess I'll hold off updating the BIOS for now
though.  I bought the motherboard not two weeks ago, together with a
Athlon 900MHz processor and it has BIOS version 1004D.  I have seen
problems even with Windows using the 1005D version though.  My shop has
been selling a LOT of this board; the problems we've seen come back seem
to be specifically related to 1005D.  Reflashing to 1004D has cured any
problems I've seen.  I've not seen any new hardware come through from
the factory with 1006 though.

