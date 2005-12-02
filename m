Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVLDCHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVLDCHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 21:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVLDCHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 21:07:21 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:7383 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S932194AbVLDCHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 21:07:20 -0500
Message-Id: <200512021830.jB2IUtcK015628@pincoya.inf.utfsm.cl>
To: Coywolf Qi Hunt <coywolf@gmail.com>
cc: Bill Davidsen <davidsen@tmr.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values 
In-Reply-To: Message from Coywolf Qi Hunt <coywolf@gmail.com> 
   of "Sat, 03 Dec 2005 01:07:04 +0800." <2cd57c900512020907h4be23519q@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 02 Dec 2005 15:30:55 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> 2005/12/3, Bill Davidsen <davidsen@tmr.com>:
> > Coywolf Qi Hunt wrote:

> > > This is a reason why enums are worse than #defines.
> > >
> > > Unlike in other languages, C enum is not much useful in practices.

> > Actually they are highly useful if you know how to use them. They allow
> > type checking, have auto increment, and are part of the language instead
> >   of a feature of the preprocessor.

The preprocessor /is/ part lof the language...

> Yes, I know type checking and auto increment. But they are not
> worthwhile, at least not for serious C programming.

They do have their uses. No, C (particularly as used today) is not a
"designed" language, it has several ways of doing the same thing, some
quirks, and outright design mistakes.

>                                                     No, I don't know
> how to use them comfortably.

Then you aren't fit to judge, are you?

> What's wrong with sorted macros? They are more flexible

"More flexible" == "more leeway to screw up"...

>                                                         and readable.

"Readable" is in the eye of the beholder...

> enums just look weird.

Ditto.

>                        We also share macros b/w C and asm.

So what?

[...]

> Follow you logic, C standard should only specify C language, not
> anything of libc...  I have no interest in arguing the relations b/w C
> and cpp.

libc is part of the language, as is cpp.

[...]

> > It would have been good to use enums in the first place, I can't see
> > changing now because of the effort involved.

> You contradict yourself rather.

No. The difference between them is not /that/ large, and by now the use of
#define is so much part of the "way things are done" that the pain of
changing it doesn't buy you enough.

What I see is that you don't know too much about large-scale software
development (and Linux is definitively in that league).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
