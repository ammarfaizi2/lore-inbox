Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280467AbRJaUDU>; Wed, 31 Oct 2001 15:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280465AbRJaUCx>; Wed, 31 Oct 2001 15:02:53 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:42493 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S280464AbRJaUCe>; Wed, 31 Oct 2001 15:02:34 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Michael Peddemors <michael@wizard.ca>
Cc: Sujal Shah <sshah@progress.com>, linux-kernel@vger.kernel.org
Date: Wed, 31 Oct 2001 11:39:38 -0800 (PST)
Subject: Re: What is standing in the way of opening the 2.5 tree?
In-Reply-To: <1004555927.11209.45.camel@mistress>
Message-ID: <Pine.LNX.4.40.0110311134520.7434-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

we can have a 2.4 kernel that's fully tested if you can come up with a
test plan that covers all possible issues.

the fundamental problem with 2.4 has been that the VM system works when
tested by the people developing it. they hit it with everything they can
think of and are happy with the results (or if there are issues they ahve
they think they are rare enough not to be a problem)

the kernels are then released and other people hit them with different
loads and things collapse. This is the problem and the reason that 2.5 has
not been opened.

once the VM system is stable (and it sounds like we are almost there) then
the few remaining issues will be fixed as they are discovered and more
drastic changes can happen in 2.5

people seem to have the idea that linus and alan have been making all the
VM changes to the kernel for the fun of it or to test new things, they
have been making the changes becouse the old version was shown to be
horribly bad in some case.

there are other changes that have made it into the kernel during this time
and I won't go into them, but the key reason there isn't a 2.5 yet is the
VM problems.

David Lang



 On 31 Oct 2001, Michael Peddemors
wrote:

> Date: 31 Oct 2001 11:18:47 -0800
> From: Michael Peddemors <michael@wizard.ca>
> To: Sujal Shah <sshah@progress.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: What is standing in the way of opening the 2.5 tree?
>
> Full moon must be getting to me, I have to open my mouth, and howl my
> opinion..
>
> As a consultant, it seems a shame to open up a 2.5 UNTIL 2.4 is dead
> stable.. When it comes to servers, I still have to recommend that my
> clients stick to a 2.2 series..  Of course, I am subject to some deep
> flames as well, but we defienlty aren't getting enough testing in the
> -pre series each time..
> So far, every 2.4.x release has followed with a series of OOPS, OOM
> problems, last minite updates to the pre cycle that caused bugs..  The
> 2.4 series has changed So many fundamentals since 2.4.0 that it seems
> more like it is still 2.3. under development.
>
> Although a few vendors are supplying 2.4 kernels with relative success,
> I cannot with good conscious say that my clients servers will be
> bulletproof like the 2.2 series was..
>
> (I say this as I just finished a work order for a new Oracle Server,
> still on 2.2)
>
> I am surely looking for the next in the 2.4 series, as it seems like we
> are finally solidifying, but when I look at all of the reccomendations
> for 'which 2.4' kernel to use, it is amazing at how many people are
> recommending kernels or a -pre nature, or -ac - even -aa as the most
> solid.. When I would expect to see everyone recommending a single
> production Linus Kernel version.
>
> Can we get a single 2.4 series kernel that has fully been tested before
> moving on to even more fundamental changes?
> >
> > To be honest, I think that any x.y.z kernel is "unstable."  As we move
> > into a situation with an even larger installed base, I think you're
> > going to see a third tier become more evident: a) unstable, b) stable,
> > c) vendor supported.  Quite frankly, if I'm making recommendations to
> > customers and clients for a linux installation, I typically recommend
> > for them to go with a vendor supplied kernel and manage it through the
> > vendor.
> >
> > > Please read the FAQ at  http://www.tux.org/lkml/
> --
> "Catch the Magic of Linux..."
> --------------------------------------------------------
> Michael Peddemors - Senior Consultant
> LinuxAdministration - Internet Services
> NetworkServices - Programming - Security
> Wizard IT Services http://www.wizard.ca
> Linux Support Specialist - http://www.linuxmagic.com
> --------------------------------------------------------
> (604)589-0037 Beautiful British Columbia, Canada
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
