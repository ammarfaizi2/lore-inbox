Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbVLFCUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVLFCUp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbVLFCUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:20:45 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:46231 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S964925AbVLFCUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:20:44 -0500
Message-Id: <200512060157.jB61v0cE004648@pincoya.inf.utfsm.cl>
To: Bill Davidsen <davidsen@tmr.com>
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from Bill Davidsen <davidsen@tmr.com> 
   of "Mon, 05 Dec 2005 18:03:33 CDT." <4394C745.2020802@tmr.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Mon, 05 Dec 2005 22:56:59 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:
> Ben Collins wrote:

> > What you're suggesting sounds just like going back to the old style of
> > development where 2.<even>.x is stable, and 2.<odd>.x is development.
> > You might as well just suggest that after 2.6.16, we fork to 2.7.0, and
> > 2.6.17+ will be stable increments like we always used to do.

> I'll let him speak to what he intended, but my idea of stable is to
> keep the features of 2.6.0 in 2.6.N for any value of N.

That works iff N == 0.

>                                                         Adding new
> stuff rapidly hasn't been nearly the problem people feared,

... because they had the leeway to change broken/unsuitable things to fit,
and because the tools today are so much better...

>                                                             but that's
> largely due to the efforts of akpm to act as throttle, and somehow get
> more people to try his versions and knock the corners off the new code
> before it goes mainline.

Heroic efforts, sure.

> I do think the old model was better;

It just /didn't work/. You don't remember the pain of jumping from 2.2 to
2.4, do you? Sure, while 2.2 lasted it was stable, but everybody screamed
that the latest&greatest whatever-card didn't work, and either jumped to
2.3.x du jour (good luck! had to futz around with lots of matching userland
changes /without/ distro support for that) or choose a distro which shipped
a patched 2.3 kernel (which was totally incompatible when 2.4 showed up) or
(tried to) backport features to 2.2 (ditto, resulting from a /huge/ amount
of wasted effort).

>                                      by holding down major changes for
> six months or so after a new even release came out, people had a
> chance to polich the stable release,

No chance. The people who would have been doing so just got bored and
looked elsewhere for challenges. Do enough of that, and you'll be left
without any volunteers at all.

>                                      and developers had time to
> recharge their batteries so to speak, and to sit and think about what
> they wanted to do, without feeling the pressure to write code and
> submit it right away.

This assumes kernel development is uniform movement. Far from it, at any
moment there are pieces that haven't been touched in ages, others in active
turnover, others just finished being worked over.

>                       Knowing that there's no place to send code for
> six months is a great aid to generating GOOD code.

For something else, sure.

> The other advantage of a development tree was that features could be
> added and removed without the argument that it would break this or
> that. It was development, no one was supposed to use it for
> production, no one could claim that there was even an implied promise
> of things working or even existing.

With the current tools, that development can be done outside the vanilla
tree, and integrated with not too much pain. The /reason/ for "wild
development" phases is not there anymore.

>                                     ipchains could have gone out of
> 2.6 with no more fuss than xiafs departing. The people who really want
> it stay with the old kernel.

Come on, it has been announced for a /long/ time. It is not like anybody
could have been caught unaware. More like people thinking it would /never/
be done as it was called so long before...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
