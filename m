Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030798AbWI0Ul5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030798AbWI0Ul5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030800AbWI0Ul5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:41:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030798AbWI0Ul4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:41:56 -0400
Date: Wed, 27 Sep 2006 13:41:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <m33bad9hgy.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.64.0609271336200.3952@g5.osdl.org>
References: <43447.192.54.193.51.1159350218.squirrel@rousalka.dyndns.org>
 <Pine.LNX.4.64.0609271031300.3952@g5.osdl.org> <m33bad9hgy.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Sep 2006, Krzysztof Halasa wrote:
> > And it not at all uncommon to have a flash that simply cannot be upgraded 
> > without opening the box. Even a lot of PC's have that: a lot (most?) PC's 
> > have a flash that has a separate _hardware_ pin that says that it is 
> > (possibly just partially) read-only. So in order to upgrade it, you'd 
> > literally need to open the case up, set a jumper, and _then_ run the 
> > program to reflash it.
> 
> I think this is history. Yes, late 486s and Pentiums (60 and 66?)
> had a jumper protecting the flash. It's not true since ca. "Pentium 75+"
> days - while many boards use "bootblock" chips, it's (almost?) always
> unprotected (at most it just requires setting some GPIO pin(s)). The
> rest of flash obviously has to be R/W to support the ESCD etc.

You're probably right. The pin still exists on the flash chips, but most 
of the time on PC's at least the writability is software-controlled.

I think the hatred of pins became so high that it became almost 
unacceptable for motherboard designers to add them on PC's. Nobody wants 
to open their case any more ;)

But the whole point was to just show how silly the whole "upgradable" vs 
"not upgradable" discussion is. We're literally talking about something 
where apparently it matters to the GPLv3 whether a pin on a chip is 
connected to software or hardware (or not at all). Is that sane?

So if it's "hardware-controlled", it would be ok (because it's not meant 
to be upgraded at all)? But if it's software-controlled it is not? A set 
of rules that require this kind of nitpicking is just broken.

			Linus
