Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131154AbQLHUFz>; Fri, 8 Dec 2000 15:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbQLHUFp>; Fri, 8 Dec 2000 15:05:45 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:1287 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S131154AbQLHUFf> convert rfc822-to-8bit;
	Fri, 8 Dec 2000 15:05:35 -0500
Date: Fri, 8 Dec 2000 11:34:51 -0800 (PST)
From: Mark Vojkovich <mvojkovich@valinux.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Andi Kleen <ak@suse.de>, Rainer Mager <rmager@vgkk.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 
In-Reply-To: <25692.976268767@redhat.com>
Message-ID: <Pine.LNX.4.30.0012081129140.6704-100000@beefcake.hdqt.valinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2000, David Woodhouse wrote:

>
> ak@suse.de said:
> >  Sounds like a X Server bug. You should probably contact XFree86, not
> > linux-kernel
>
> I quote from the X devel list, which perhaps I shouldn't do but this is hardly
> NDA'd stuff:
>
> On Mon 20 Nov 2000, mvojkovich@valinux.com said:
> >   I have seen random crashes on dual P3 BX boards (Tyan) and dual Xeon
> > GX boards (Intel).  XFree86 core dumps indicate that it happens in
> > random places, in old as dirt software rendering code that has nothing
> > wrong with it.  I've only seen this under 2.3.x/2.4 SMP kernels.  I
> > would say that this is definitely a kernel problem.
>
> XFree86 3.9 and XFree86 4 were rock solid for a _long_ time on 2.[34]
> kernels - even on my BP6¹. The random crashes started to happen when I
> upgraded my distribution² - and are only seen by people using 2.4. So I
> suspect that it's the combination of glibc and kernel which is triggering
> it.

   Some additional data points.  It goes away on UP 2.4 kernels.
Also, I can't recall seeing this problem on IA64.  Maybe it's still
there on IA64 and I just haven't been trying hard enough to crash
it, but my current impression is that the problem doesn't exist on IA64.

  Hmmm...  IA64 is a static server.  I don't hear of people having
problems on 3.3.6 servers either.  I'm wondering if a non-loader
4.0 server would have problems on IA32 with a 2.4 kernel.  That's
something for people to try.


				Mark.

>
> --
> dwmw2
>
> ¹ And the BP6 still falls over less frequently than the dual P3 I use at
> work.
> ² RH7. Don't start.
>
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
