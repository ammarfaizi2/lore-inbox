Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbVJEQCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbVJEQCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVJEQCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:02:03 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:29096 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030195AbVJEQCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:02:01 -0400
Message-Id: <200510050059.j950x6v2004304@laptop11.inf.utfsm.cl>
To: Marc Perkel <marc@perkel.com>
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Message from Marc Perkel <marc@perkel.com> 
   of "Tue, 04 Oct 2005 12:47:25 MST." <4342DC4D.8090908@perkel.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 04 Oct 2005 20:59:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 05 Oct 2005 12:01:24 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel <marc@perkel.com> wrote:
> I think it's time for some innovative thinking and for people to step
> outside the Linux box and look around at other operating systems for
> some good ideas. I'll run through a few ideas here.

Great! Where are your patches?

> Reiser 4 - The idea of building a file system on top of a database is
> the right way to go.

It's insanity. I'll give it to you in writing, if you want.

>                      Reiser is onto something here and this is a
> technology that needs to be built upon. It's current condition is a
> little on the week side - no ACLs for example - but the underlying
> concept is ound.

There are many who disagree. Even violently...

> Novell Netware type permissions. ACLs are a step in the right
> direction but Linux isn't any where near where Novell was back in
> 1990.

Details?

>       Linux lets you - for example - to delete files that you have no
> read or write access rights to.

Yep. This is spelled U-N-I-X. You just (re)discovered the most "discovered"
(by newbies) "security bug" in Unix.

>                                 Netware on the other hand prevents you
> from deleting files that you can't write to and if you have no right
> it is as if the file isn't there.

Sorry, but you don't "delete a file" here, you delete a /link/ to a file.
Yes, if it was the last one the file goes away, but that is just a special
case.

>                                   You can't even see it in the
> directory. Netware also has inherited permissions like Windows

Inherited permissions are /evil/, as you need to check all the way up to /
to find out if something is allowed or not.

>                                                                and
> Samba has and this is doing it right. File systems and individual
> directories should be able to be flagged as
> casesensitive/insensitive.

Here file names aren't made up of "letters" that have "cases", they are
just random strings of (almost unrestricted) bytes. So you are free to
interpret them as japanese or arabic. Your choice.

>                            Permissions need to be fine grained and
> easy to use.

"Fine grained" is almost exactly the opposite to "easy to use".

>              Netware is a good example to emulate.

Go ahead and write your filesystem then! It might even be of some use to be
able to read Netware volumes. I'm not trying to stop you.

> The bootup sequence of Linux is pathetic.

This has nothing to do with Linux (the kernel).

>                                           What an ungodly mess. The
> FSTAB file needs to go and a smarter system needs to be developed. I
> know this isn't entirely a kernel issue but it is somewhat related.

In some 30 years nobody has been able to come up with something better. If
you have a better idea, I'm all ears. Note that the mechanism would have to
be just as simple (or hopefully simpler).

> I think development needs to be done to make the kernel cleaner

Sign up with the kernel janitors.

>                                                                 and
> smarter

That's part of the idea around here.

>         rather than just bigger

Nobody is advocating "bigger". It grows mostly to handle new pieces of
hardware, or new requirements. Again, if you have concrete proposals on how
to shrink the kernel, everybody here will jump of joy. Big is slow, and
thus bad.

>                                 and faster.

What is bad about "faster"?

>                                             It's time to look at what
> users need

The distribution people are looking into that, don't worry.

>            and try to make Linux somewhat more windows like in being
> able to smartly recover from problems.

Please, everything /but/ "Windows style problem recovery"! I /much/ prefer
the system to crash than to (silently) paper over serious problems until it
is far too late to do anything about their effects.

>                                        Perhaps better error messages
> that your traditional kernel panic or hex dump screen of death.

Patches are more than welcome.

> The big challenge for Linux is to be able to put it in the hands of
> people who don't want to dedicate their entire life to understanding
> all the little quirks that we have become used to. The slogan should
> be "this just works" and is intuitive.

It is almost there, in the form of the more user-friendly distributions.
Again, help is higly appreciated there.

> Anyhow - before I piss off too many people who are religiously
> attached to Linux worshiping - I'll quit not. ;)

Thanks.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
