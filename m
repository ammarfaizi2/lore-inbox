Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbRGPCU3>; Sun, 15 Jul 2001 22:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbRGPCUK>; Sun, 15 Jul 2001 22:20:10 -0400
Received: from [160.79.55.71] ([160.79.55.71]:19979 "EHLO degler.net")
	by vger.kernel.org with ESMTP id <S267184AbRGPCUB>;
	Sun, 15 Jul 2001 22:20:01 -0400
Date: Sun, 15 Jul 2001 22:19:31 -0400
From: Stephen Degler <sdegler@degler.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Again: Linux 2.4.x and AMD Athlon
Message-ID: <20010715221931.A39058@crusoe.degler.net>
In-Reply-To: <3B5141A0.2B98693@athlon.maya.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B5141A0.2B98693@athlon.maya.org>; from andihartmann@freenet.de on Sun, Jul 15, 2001 at 09:09:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a data point that may be of some value.  I have 3 athlon systems
running a variety of FreeBSD/NetBSD/Linux and I experience rock solid
stability, even with K7 optimized 2.4 kernels.  The things that seem to
be different for me are that:
	1) I always use scsi disk subsystems (adaptec or symbios).
	2) I do not use nvidia graphics cards.

My boards are Abit (kt7raid, kt7) and Asus (a7v).  I have taken no special
power supply precautions beyond using AMD certified units.  I'm very curious
as to why I have had such an excellent experience (I'm unlikely to purchase
an intel cpu at this point), even though I use the dreaded via chipsets. 

I hope that someone finds this useful.  I'd be happy to supply configs or
other details if desired.

skd

On Sun, Jul 15, 2001 at 09:09:20AM +0200, Andreas Hartmann wrote:
> Hello all,
> 
> On Friday 13 July 2001 13:12, Thomas Foerster wrote:
> 
> > I got only one oops in inode.c (forget the actual line number)
> > The rest are random application crashes on XFree 4.0.3 (GeForce2 GTS, nVidi
> > DRI (older version)) The System NEVER hangs, only applications crash!
> 
> Some more experiences with AMD and X-related crashes:
> -> I've an Athlon 800 on a Epox EP7KXA Mobo (686A) with 512MB RAM and no
> nVIDIA graphics card, but ATI XPERT 2000.
> 
> I've got similar problems with 2.4.x-kernels and I would be very glad,
> if the cause could be found. The problem is more than half of a year
> old!
> I posted it in this list some time ago (more than once) - nobody seemed
> to be interested. I posted it 2 times to the X bug list - no interest.
> 
> But as I can see now, the problem seems to be greater than I thoght.
> Therefore I write here some of my latest experiences:
> 
> 
> # X 4.1 (if I remember right) and 2.4.6 -> a lot off solid crashes (even
> pinging the machine didn't work) while starting X, no matter if DRI was
> turned on or off; no matter if agp was loaded or not. Unuseable.
> 
> # X-CVS and 2.4.6ac2 eg. is working fine - with DRI turned on - I didn't
> test it without DRI.
> 
> # Before, I tried to run X 4.1 and ac-Kernels. They have been crashing
> too as described above. That's why I'm using X CVS.
> 
> # If I try to run X CVS and vanilla 2.4.6, I'm getting blinking screens
> after some restarts of X or after long working with X. It's unuseable,
> too.
> 
> 
> For me, it seems to be not a nVIDIA related problem.
> 
> The question for me is:
> where are the differences between X CVS / X 4.1 and Vanilla / ac-patches
> - and there combinations.
> Why is the combination 2.4.6ac2 or the ac-patches before and X CVS
> (about 4 weeks old; not DRI-CVS; but they have been merged as far as I
> know) working for me without any problems?
> 
> Did you try this combination too? It would bee interersting if it would
> work for you too!
> 
> 
> Regards,
> Andreas Hartmann
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
