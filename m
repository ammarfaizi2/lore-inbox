Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263450AbUDGCoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 22:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUDGCoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 22:44:25 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38588 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263450AbUDGCoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 22:44:23 -0400
Message-Id: <200404070244.i372iKdd003670@eeyore.valparaiso.cl>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Tue, 06 Apr 2004 15:05:21 MST."
             <20040406220521.56509.qmail@web40513.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 06 Apr 2004 22:44:20 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> --- Timothy Miller <miller@techsource.com> wrote:
> > Horst von Brand wrote:

> > > OK, so you need the policy to be interpreted in-kernel (dunno why
> > > a largeish high-level general purpose language is needed for that,
> > > when a tiny interpreter for a specialized language will do very well,
> > > and has been shown to work fine), and written in a "high level
> > > language" so that your garden variety sysadmin _can_ write her own
> > > policy, but it really doesn't matter because she'll never have to do
> > > so...

> > > Completely lost me.

> > I was getting hung up on that one too, but I didn't
> > know how to say it. 
> >   You did a nice job.  :)

> Can you guys be more specific? I don't see any
> technical objections. 

As they say around here "No hay peor ciego que el que no quiere ver"
(roughly, "There is no worse blindness than not wanting to see")...

>                       The only one is that performance
> would suffer because of use of higher level language
> than C or Assembler.

Because the performance and size of kernel code is _critical_, maybe?
Because much of the kernel code has been carefully tuned for maximum
performance perhaps?

> There is a reason people use languages like PERL, Java
> and so on.

And there are solid reasons for _not_ writing operating system kernels in
them too...

>            I would prefer to spend less time writing
> actual code - this is what these high level languages
> for. If performance would be most important - people
> would do everything in Assembler, but they don't. I'd
> better write a small Assembler subroutine which will
> handle stack problems for me and benefit from using
> the high level language after that.

And then there is the technology of _inventing_ a language tailored to the
task at hand... even better than your list of high-level languages.

> There were times when userland projects were written
> in Assembler. Now people are using other languages,
> too.

In part because a mediocre compiler these days gives better code than an
assembly language coder by hand... and you can compile it for next year's
machine too.

>      May be it's time to try something new in the
> kernel, too :-) Or we will not consider that because
> nobody did that before? Someone should be the first
> :-)

It's your time you are wasting... have my blessing.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
