Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUDHCnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 22:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUDHCnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 22:43:23 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47831 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261462AbUDHCnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 22:43:20 -0400
Message-Id: <200404080243.i382hG6K003775@eeyore.valparaiso.cl>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Wed, 07 Apr 2004 10:54:18 MST."
             <20040407175418.17681.qmail@web40503.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Wed, 07 Apr 2004 22:43:16 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> --- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

[...]

> > And then there is the technology of _inventing_ a
> > language tailored to the
> > task at hand... even better than your list of
> > high-level languages.

> I started exactly with that. I found out shortly that
> have no idea of functionality needed for such kind of
> system.

Come back when you have found out.

>         It was clear that requirments for this sytem
> can change rapidly.

I would not trust anything with "rapidly changing requirements" as security
infrastructure.

>                     Only general purpose language can
> address this problem (if we want to save time of
> development and introduction of new security models).

A security model has to be exhaustively scrutinized, proved correct and
complete, and well-tested. The implementation language is completely
irrelevant, the hard work is _not_ programming.

> Example. Current security policies are 'static'.

In what sense?

>                                                  It
> seems, that it would be nice to have 'dynamic'
> policies (with support from security model).

Again, what does this mean?

>                                              Now,
> policy describes resources available for subsystem.

No...

>                                                     It
> may be useful to limit the sequence of access to
> resources - 'behaviour' of subsystem. I'm not sure if
> I want to implement that right away, but there is
> commercial system which does exactly that already (it
> was created later than VXE).

What is the use of restricting access sequences? If sequence A, B, C is
forbidden, chances are that C, B, A (or any of the other 4 permutations)
will give an attacker exactly what he wants.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
