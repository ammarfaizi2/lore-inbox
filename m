Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265659AbRGOHK3>; Sun, 15 Jul 2001 03:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265933AbRGOHKT>; Sun, 15 Jul 2001 03:10:19 -0400
Received: from mout1.freenet.de ([194.97.50.132]:201 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S265659AbRGOHKL>;
	Sun, 15 Jul 2001 03:10:11 -0400
Message-ID: <3B5141A0.2B98693@athlon.maya.org>
Date: Sun, 15 Jul 2001 09:09:20 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: Again: Linux 2.4.x and AMD Athlon
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

On Friday 13 July 2001 13:12, Thomas Foerster wrote:

> I got only one oops in inode.c (forget the actual line number)
> The rest are random application crashes on XFree 4.0.3 (GeForce2 GTS, nVidi
> DRI (older version)) The System NEVER hangs, only applications crash!

Some more experiences with AMD and X-related crashes:
-> I've an Athlon 800 on a Epox EP7KXA Mobo (686A) with 512MB RAM and no
nVIDIA graphics card, but ATI XPERT 2000.

I've got similar problems with 2.4.x-kernels and I would be very glad,
if the cause could be found. The problem is more than half of a year
old!
I posted it in this list some time ago (more than once) - nobody seemed
to be interested. I posted it 2 times to the X bug list - no interest.

But as I can see now, the problem seems to be greater than I thoght.
Therefore I write here some of my latest experiences:


# X 4.1 (if I remember right) and 2.4.6 -> a lot off solid crashes (even
pinging the machine didn't work) while starting X, no matter if DRI was
turned on or off; no matter if agp was loaded or not. Unuseable.

# X-CVS and 2.4.6ac2 eg. is working fine - with DRI turned on - I didn't
test it without DRI.

# Before, I tried to run X 4.1 and ac-Kernels. They have been crashing
too as described above. That's why I'm using X CVS.

# If I try to run X CVS and vanilla 2.4.6, I'm getting blinking screens
after some restarts of X or after long working with X. It's unuseable,
too.


For me, it seems to be not a nVIDIA related problem.

The question for me is:
where are the differences between X CVS / X 4.1 and Vanilla / ac-patches
- and there combinations.
Why is the combination 2.4.6ac2 or the ac-patches before and X CVS
(about 4 weeks old; not DRI-CVS; but they have been merged as far as I
know) working for me without any problems?

Did you try this combination too? It would bee interersting if it would
work for you too!


Regards,
Andreas Hartmann
