Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUD1EZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUD1EZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 00:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUD1EZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 00:25:20 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45805 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264637AbUD1EZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 00:25:13 -0400
Message-Id: <200404280323.i3S3N19W024148@pincoya.inf.utfsm.cl>
To: Marc Boucher <marc@linuxant.com>
cc: David Gibson <david@gibson.dropbear.id.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license 
In-Reply-To: Message from Marc Boucher <marc@linuxant.com> 
   of "Tue, 27 Apr 2004 21:14:32 -0400." <677BC9FC-98B1-11D8-85DF-000A95BCAC26@linuxant.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 27 Apr 2004 23:23:01 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher <marc@linuxant.com> said:
> On Apr 27, 2004, at 8:25 PM, David Gibson wrote:
> > On Tue, Apr 27, 2004 at 08:02:03PM -0400, Marc Boucher wrote:
> >> Rusty, the workaround was done a while ago, back in the 2.5 days
> >> when your new module code was still very much in flux. It was
> >> necessary to have an effective short-term solution for the existing
> >> installed base (2.4), since we could not continue to confuse
> >> customers while waiting for the patch to propagate. In other cases,
> >> we have gladly submitted patches when we encountered bugs and could
> >> fix them. Had we known that the module fix was so simple, it would
> >> of course have been submitted it to you in parallel.

> > No, it wasn't *necessary*:  you made a choice that not confusing your
> > customers was more important to you than not increasing the support
> > burden on kernel developers by releasing a silently tainted module
> > into the wild.

> In an enterprise, customers always come first. Nonetheless, I don't
> believe that this issue had a significant impact on kernel developers.

You have absolutely no right to place _any_ burden at all on kernel
hackers. "I don't believe..." just doesn't cut it.

[...]

> Futile attempts to perform license checks generating redundant and
> confusing errors, restricting access to kernel APIs for religious 
> reasons,

So? It is not _your_ call to decide under what conditions (if any) you are
allowed to use said APIs. You did not comply with the conditions as stated.
Nothing more to be said about it, you admitted so yourself.

> and the general lack of stable APIs and pragmatic understanding for the
> needs of third-party driver suppliers result in much greater everyday
> inconveniences  to ordinary users and are more damaging to the 
> acceptance

Third-party driver suppliers are welcome to work _with_ the kernel
community, who will in many cases happily fix their drivers as a matter of
course when updating the kernel. As long as source is available, that
is. If not, hackers don't want to spend time for _others_ to be able to
reap benefits. Go read the GPL, and then think hard about why Linux hackers
elected the GPL as the license for the kernel.

> of linux than the theoretical inconvenience our workaround might have
> caused to kernel developers.

There is a very down-to-earth inconvenience called "license violation"
here. You got a license to use the kernel API under certain conditions, you
violated those.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
