Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUD1Twr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUD1Twr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUD1Twm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:52:42 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49288 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264975AbUD1RGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:06:00 -0400
Message-Id: <200404281705.i3SH5mXB003817@eeyore.valparaiso.cl>
To: Marc Boucher <marc@linuxant.com>
cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license 
In-Reply-To: Message from Marc Boucher <marc@linuxant.com> 
   of "Wed, 28 Apr 2004 02:04:12 -0400." <DF14FD4C-98D9-11D8-85DF-000A95BCAC26@linuxant.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Wed, 28 Apr 2004 13:05:46 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher <marc@linuxant.com> said:
> On Apr 27, 2004, at 11:23 PM, Horst von Brand wrote:
> > Marc Boucher <marc@linuxant.com> said:

[...]

> >> In an enterprise, customers always come first. Nonetheless, I don't
> >> believe that this issue had a significant impact on kernel developers.

> > You have absolutely no right to place _any_ burden at all on kernel
> > hackers. "I don't believe..." just doesn't cut it.

> I stated a personal opinion based on the observation that the issue was
> raised in a politically provocative way. It didn't come up because
> specific kernel developers were having a hard time debugging systems with
> our drivers.

You don't _know_ that for a fact; due to the fraudulent modules perhaps
they lost untold hours trying to find out how something broke, with no hope
to find it because it was your module.

> People should understand that we are really trying to help Linux by
> providing alternative support and drivers for proprietary hardware that
> otherwise cannot be easily handled in the traditional free-software ways,
> otherwise they would already have been implemented long ago by one of the
> many talented linux kernel hackers out there.

More power to you! But when doing so _please_ do respect the wishes (and
conditions) they place on whoever does so. That is all that is being asked
from you. Not give up your firstborn, not cough up lots of dough, not sign
obnoxious NDAs, nothing.

> Folks who do not agree with the freedom of choice we are providing can
> simply avoid purchasing hardware without 100% open-source drivers,
> instead of launching political attacks based on incorrect facts or
> behaving like a wild mob using intimidation practices (someone posted my
> personal physical address on Slashdot today).

I strongly condemn such an action.

[...]

> >> Futile attempts to perform license checks generating redundant and
> >> confusing errors, restricting access to kernel APIs for religious
> >> reasons,

> > So? It is not _your_ call to decide under what conditions (if any) you
> > are allowed to use said APIs. You did not comply with the conditions
> > as stated. Nothing more to be said about it, you admitted so
> > yourself.

> AFAIK, no GPLONLY APIs are involved.

Then why fake GPL at all?

>                                      The workaround is for a confusing
> cosmetic issue that has been acknowledged by kernel developers and is
> being fixed. I have also sent Rusty a proposal for a technical change in
> our modem drivers that would restore tainting (again, there was never any
> intent, motivation nor purpose to bypass that)

Tainting messages are there among others to warn people they are running a
non-supported configuration. Bypassing that "for cosmetic reasons" is
exactly bypassing an important reason for tainting. It also gets in the way
of kernel hackers trying to help said customers with their problems, so it
bypasses the other reason for tainting.

>                                                while keeping the volume
> of messages under control.

You should have asked, and helped fix it (e.g., comming up with a means to
show the message once for a group of related modules, or making all modules
that don't contain binary blobs truly GPL (in the process defining
interfaces that other winmodems could use, perhaps), or whatever). "Sorry,
your door didn't open. I needed to get in, so I broke it down." won't go
down too well if it is your house they are talking about...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
