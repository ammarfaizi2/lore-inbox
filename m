Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319453AbSILGd7>; Thu, 12 Sep 2002 02:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319454AbSILGd7>; Thu, 12 Sep 2002 02:33:59 -0400
Received: from dp.samba.org ([66.70.73.150]:36782 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319453AbSILGd6>;
	Thu, 12 Sep 2002 02:33:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Daniel Phillips <phillips@arcor.de>
Subject: Re: [RFC] Raceless module interface 
Cc: Alexander Viro <viro@math.psu.edu>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Oliver Neukum <oliver@neukum.name>,
       Roman Zippel <zippel@linux-m68k.org>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
In-reply-to: Your message of "Thu, 12 Sep 2002 06:11:55 +0200."
             <E17pLKe-0007ds-00@starship> 
Date: Thu, 12 Sep 2002 15:35:50 +1000
Message-Id: <20020912063848.E10EF2C0B6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E17pLKe-0007ds-00@starship> you write:
> As I recall, you are the one who proposed eliminating the ability
> to unload modules entirely, because you were not able to solve the
> unload races.

Huh?  I was able to solve the module races, in multiple ways.  I even
had an implementation, using two stage init and two stage remove.  But
it's not *simple*, and pushing additional constraints on kernel driver
authors may be worse than not being able to remove modules.

>  It's a good thing that people with more sense shouted you down.

There was (understandably) some resistance to removing a "working"
feature, but noone produced a new workable alternative.

The *point* of my presentation was to make people think of
alternatives, especially, if we can't (or don't want to) solve all the
unload races, is it OK to say "well, you can't unload those kind of
modules"?

If I had come up with a clear winner, I might have saved myself the
pain of standing up in front of 70 of my peers and admitting that I
wasn't smart enough, ferchissakes.

But it doesn't help if you don't listen, then sprout the "one true
solution" which turns out to be a wordy combination two previously
discussed schemes, with the disadvantages of both.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
