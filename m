Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSIPA1f>; Sun, 15 Sep 2002 20:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318332AbSIPA1f>; Sun, 15 Sep 2002 20:27:35 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:60689 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S318310AbSIPA1e>; Sun, 15 Sep 2002 20:27:34 -0400
Message-Id: <200209160032.g8G0WQ3l010820@pincoya.inf.utfsm.cl>
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34 
In-Reply-To: Message from Daniel Phillips <phillips@arcor.de> 
   of "Sun, 15 Sep 2002 18:41:50 +0200." <E17qcT1-0000D7-00@starship> 
Date: Sun, 15 Sep 2002 20:32:26 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc:'s mercilessly chopped down]
Daniel Phillips <phillips@arcor.de> said:

[...]

> Linux is WAY WAY far from being a really nice development environment.
> It's really nice in many other ways, but not in that way.
> 
> For example, there is no excuse for ever needing more than 1/4 second
> to get from the function you're looking at on the screen to its
> definition and source text, ready to read or edit.

There are tools able to do so... nothing kernel-related.

> There's no excuse for having to copy down an oops from a screen by
> hand, either.  It's nice to know you can fall back to this if you have
> to, but having that be the default way of working is just broken.

Yes, I had to do that a (very) few times, when the machine went south and
logging was dead before. But is is not the "default way" by any long shot.

> There's no excuse for having to pepper low level code with printk's
> to bracket a simple segfault.

It is no excuse to make _every_ kernel out there slow just for the
hypothetical case it might crash sometime. Be optimistic, man! ;-)

> OK, I'll stop there.  Actually, the only thing I'm really irritated
> about at the moment is the attitude of people who should know better,
> promoting the fiction that this veggie-zen-tools-made-out-of-wood
> thing is actually helping the kernel progress faster.

Who said it makes the kernel progress faster? Kernel progress' bottleneck
is the few people who know it in and out, and so are in position to decide
on the patches presented to them. (It also depends on the scarcity of
kernel architects, and no thanks, a comittee doing that work would get me
to run away from Linux _very_ fast indeed; but that is irrelevant here).

Now, the productivity of the head developers/integrators is as high as the
average quality of the patches they get. If Aunt Tillie and her sisters get
a kernel debugger and start spewing off "Set to a random non-NULL value so
it doesn't crash" patches kernel development will grind to a halt.

Yes, debuggers have their uses. But the ones I've used on userland programs
were much, much less useful than you seem to think. Sure, it is nice to be
able to check on the values in a data structure to find out how it got
screwed up, but that's it (and that is a very occasional use for me, when
other approaches have failed). And a kernel Oops usually gives you enough
to work that out.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
