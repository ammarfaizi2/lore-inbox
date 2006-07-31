Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWGaQRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWGaQRW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWGaQRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:17:22 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:236 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030211AbWGaQRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:17:21 -0400
Message-Id: <200607311617.k6VGH3YH009055@laptop13.inf.utfsm.cl>
To: "Denis Vlasenko" <vda.linux@googlemail.com>
cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs? 
In-Reply-To: Message from "Denis Vlasenko" <vda.linux@googlemail.com> 
   of "Mon, 31 Jul 2006 10:26:55 +0100." <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 31 Jul 2006 12:17:03 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 31 Jul 2006 12:17:03 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda.linux@googlemail.com> wrote:
> The reiser4 thread seem to be longer than usual.
> Let me, a mere user, add some input.

Please don't.

> It looks to me that delay with reiser4 acceptance
> is caused by two different things.
> 
> First, reiser4 adds those plugins which many FS people
> see as belonging to VFS layer rather than to particular FS.

Right.

> And second, reiser team was a bit lax at fixing bugs.

Right!

> Not too bad when compared to other FSes, but still.

How did you compare?

> When singled out, none of these things are bad enough to hold off
> inclusion. However, combined impact of _both_ of them
> did upset maintainers enough.

Plus a, lets say, less than cooperative overall attitude, and a marked
tendency to try to sneak changes in by political arm-twisting.

> Frankly, on the first problem I think that you are right, Hans, and
> putting plugins into VFS _now_ makes little sense because we can't know
> whether anybody will ever want to have plugins for some other FS, so
> requiring reiser people to do all the shuffling _now_ for questionable
> gain is simply not fair. It can be done later if needed.

You are wrong. ReiserFS has no "right" to be allowed into the kernel. If
the people in charge of maintaining the filesystem infrastructure of the
kernel say something about your patches, you either take heed (and so
increase your chance of being accepted someday), or stay out. It is /their/
game, after all.

> It leaves you with the other option: remove the second problem.

That has to be done regardless. Buggy code with authors that can't be
bothered to fix it just means more work for the (thinly spread) kernel
hackers, so it is an absolute no-no-no.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
