Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWI1UoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWI1UoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWI1UoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:44:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58042 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750771AbWI1UoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:44:17 -0400
Date: Thu, 28 Sep 2006 13:43:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.61.0609280947360.21498@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0609281317410.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <1159319508.16507.15.camel@sipan.sipan.org>  <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
  <1159342569.2653.30.camel@sipan.sipan.org>  <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
 <1159359540.11049.347.camel@localhost.localdomain> <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
 <Pine.LNX.4.61.0609280947360.21498@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Sep 2006, Jan Engelhardt wrote:

> 
> >People don't have a clue!
> >
> >Grep for it, if you want to. The word "link" simply DOES NOT EXIST IN THE 
> >LICENSE!
> 
> Hah then read LICENSE.LGPL!

Thank you for proving my point.

The part you quote aren't part of the license. They're in the same file, 
but they are separate from the actual text of the license. It's called the 
"preamble", and you should really realize what it means. 

The _license_ is the legal part. It's the thing between "terms and 
conditions" and "end of terms and conditions".

I like being right, but I hate being proven right quite so quickly.

(Btw, the license you quoted wasn't even the GPL. The LGPL - which is a 
totally different thing - _does_ indeed talk about "linking", but the part 
you quoted wasn't even _in_ that license, so it was kind of doubly silly 
to bring that part up, now wasn't it?)

> If the GPL does not mention linking at all, and therefore does not
> really forbid it, why do we need an LGPL to allow linking then?

Where did you learn logic?

The GPL doesn't mention linking, because the GPL only talks about derived 
works. The LGPL talks about linking, because it wants to _narrow_ its 
scope from "derived works" to something smaller, and makes it clear that 
even within a derived work, the technical thing of "linking" actually 
consitutes a license boundary.

However, the fact IN NO WAY logically implies the reverse is true. The 
fact that you link (or not) _in_itself_ does not necessarily imply a 
boundary of derived works.

Your logic is so horribly flawed that it's not even funny. It's the same 
thing as if you said

  - Aristotle is a man
  - I am not Aristotle
  - Therefore I am not a man

Please take a course in Logic 101.

		Linus

PS. Just so that you don't confuse things _again_, I'd like to repeat: 
pretty much everybody would agree that linking is often a damn strong 
reason to believe the things are related and probably derived works. But 
it's not at all a logical conclusion, and it's not at all necessarily 
always right. "Derived work" is a lot more complicated than that.

Linking with a GPL'd version of a standard C library (ie a non-GPL'd 
version would have worked equally well, and you just did it becasue you 
didn't think) would be very possibly (even likely) not be considered to be 
a "derived work", but "mere aggregation".

Think about that for a moment.

And realize that the reason people then use the LGPL is that with that 
license, the question above never even comes up. So you're on much safer 
ground, and you don't have to worry about crazy people suing you.

A lot of legal stuff is not just to avoid illegal things, but to 
_obviously_ avoid them. You never really want to be even close to the 
edge.
