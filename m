Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTLBTj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTLBTj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:39:57 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:46535 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S264339AbTLBTjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:39:55 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Linus Torvalds <torvalds@osdl.org>, Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Linux 2.4 future
Date: Tue, 2 Dec 2003 14:39:52 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <20031202184513.GU16507@lug-owl.de> <Pine.LNX.4.58.0312021101440.1519@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312021101440.1519@home.osdl.org>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312021439.52933.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [151.205.54.127] at Tue, 2 Dec 2003 13:39:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 December 2003 14:09, Linus Torvalds wrote:
>On Tue, 2 Dec 2003, Jan-Benedict Glaw wrote:
>> Whenever The ABI Question (TM) comes up, it seems to be about
>> claiming a (binary compatible) interface - mostly for modules. But
>> I think it's widely accepted that there isn't much work done to
>> have these truly (sp?) binary compatible (eg. UP/SMP spinlocks et
>> al.).
>
>Absolutely. It's not going to happen. I am _totally_ uninterested in
> a stable ABI for kernel modules, and in fact I'm actively against
> even _trying_. I want people to be very much aware of the fact that
> kernel internals do change, and that this will continue.
>
>There are no good excuses for binary modules. Some of them may be
>technically legal (by virtue of not being derived works) and
> allowed, but even when they are legal they are a major pain in the
> ass, and always horribly buggy.
>
>I occasionally get a few complaints from vendors over my
> non-interest in even _trying_ to help binary modules. Tough. It's a
> two-way street: if you don't help me, I don't help you. Binary-only
> modules do not help Linux, quite the reverse. As such, we should
> have no incentives to help make them any more common than they
> already are. Adn we do have a lot of dis-incentives.
>
>			Linus

Very well said Linus.  And of course I have no problem understanding 
the reasons behind the reasoning.  However, that doesn't help us pour 
schmucks out here in la-la land trying to make the most recent nvidia 
module work with the latest kernel on our now elderly gforce2's.  I'd 
like to have some OpenGL support for instance, but for everything 
else, nv is probably 100x more stable than the nvidia binary.  So we 
run nv.  Maybe someday nvidia will get baptised, but *I'm* not 
counting on it.

Its not your emails (as Linus) to nvidia that will fix that, but a 
concerted effort, emailing them for a resolution from everyone who 
owns one of their products _might_ eventually make a difference.
OTOH, they're going to listen to their IP lawyers & not us. so...

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

