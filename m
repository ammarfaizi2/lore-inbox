Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285014AbRLQFuq>; Mon, 17 Dec 2001 00:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285016AbRLQFug>; Mon, 17 Dec 2001 00:50:36 -0500
Received: from harddata.com ([216.123.194.198]:56328 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S285014AbRLQFuX>;
	Mon, 17 Dec 2001 00:50:23 -0500
Date: Sun, 16 Dec 2001 22:50:13 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Peter Rival <frival@zk3.dec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc1 does not boot my Alphas
Message-ID: <20011216225013.A4984@mail.harddata.com>
In-Reply-To: <20011216160404.A2945@mail.harddata.com> <3C1D4871.82053E7A@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1D4871.82053E7A@zk3.dec.com>; from frival@zk3.dec.com on Sun, Dec 16, 2001 at 08:20:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 08:20:49PM -0500, Peter Rival wrote:
> Michal Jaegermann wrote:
> 
> > I just happen to have an access right now to two Alpha machines,
> > UP1100 and UP1500, both with Nautilus chipset.  Neither of these
> > can be booted with 2.4.16 or 2.4.17rc1.
>
> Try again, this time adding "srmcons" to the boot flags.  You're croaking
> before we get the console set up under Linux

Thanks.  I was not aware of this flag and this is a nice tip.
Unfortunately things lock up immediately before effects of this flag
can be felt.  Even with this I am not getting a single line from
a kernel. I tried both on 1500 and 1100.  Effects are exactly the same.

Tommorow I will try to graft 'arch/alpha' from 2.4.13-ac8 to 2.4.17rc1
just to see what will happen.  Some changes have to be made before this
will even compile.  I see that some 'nautilus_init()' function showed up
in 2.4.17rc1 which was not in 2.4.13-ac8.  Hm....

I did boot 2.4.13-ac8 on UP1500 but in a short order I collected an
impressive array of "Machine checks" both "Fatal", although machine was
still running to an extent after that, and "Correctable".  If somebody
wants to look at them I can oblige. :-)  Nothing of that sort showed up
on UP1100 with the same kerel or with older kernels I was able to boot
on 1500.

  Michal
