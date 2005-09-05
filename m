Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVIEP3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVIEP3s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVIEP3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:29:48 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:9649 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932297AbVIEP3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:29:47 -0400
Message-Id: <200509051529.j85FTeGi019917@laptop11.inf.utfsm.cl>
To: Willy Tarreau <willy@w.ods.org>
cc: Sean <seanlkml@sympatico.ca>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS 
In-Reply-To: Message from Willy Tarreau <willy@w.ods.org> 
   of "Mon, 05 Sep 2005 07:01:08 +0200." <20050905050108.GA16596@alpha.home.local> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 05 Sep 2005 11:29:40 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 05 Sep 2005 11:29:42 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
> On Mon, Sep 05, 2005 at 12:47:03AM -0400, Sean wrote:

[...]

> > But the real crux of the argument here is not whether or not people should
> > ever use binary-only drivers, it's whether the open source kernel
> > developers should spend any time worrying about it or not.

> I think we should not worry about it, but we should not deliberately break
> it in a stable series when that does not bring anything.

4Kstacks sure /does/ bring something. Quite a lot, actually. Please stop
pretending that the kernel crowd is out to get innocent users just for fun
and games. There /are/ technical reasons behind the change, the change
/has/ been tested for a long time and remaining bugs have (all but) been
flushed out, and now the time for the final step has come (get rid of the
old ways once and for all).

>                                                          The fact that
> Adrian proposed to completely remove the option is sad.

I for one don't see why.

>                                                         It's in the windows
> world that you can't choose. In Linux, you make menuconfig and choose what
> suits your needs.

When it goes away, you can fork your own version of the kernel with the
legacy option, or even figure out how to fix the offending user that needs
it (funny, that was exactly what was supposed to happen in the meantime).

You could even try to brib^Wconvince a kernel developer to do the above for
you, or hire a competent hacker. Or even pool your money with others that
see the same need and put out a call for getting it done.

Perhaps even better, put pressure on the vendors that don't want to give
out specs. Find out why, try to find out if something can be worked out
(specs under NDA, but GPLed driver, perhaps).

Yes, Linux /is/ full of options. 

Just go and try to make some piece of ancient hardware work on some of the
propietary systems. /There/ you get no chance but "Oh, just change your
machine". 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

