Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbUJ0V2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUJ0V2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbUJ0VY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:24:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:58010 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262728AbUJ0VWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:22:52 -0400
Date: Wed, 27 Oct 2004 14:20:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Andrea Arcangeli <andrea@novell.com>, Larry McVoy <lm@work.bitmover.com>,
       Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
In-Reply-To: <Pine.LNX.4.61.0410272049040.877@scrub.home>
Message-ID: <Pine.LNX.4.58.0410271409420.28839@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
 <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com>
 <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com>
 <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random>
 <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random>
 <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random>
 <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
 <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org>
 <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410272049040.877@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Oct 2004, Roman Zippel wrote:
>
> The problem is that you support a license which limits everyones ability 
> on how to access the kernel source and gives Larry full control over it. 

Ok, Roman, you're on some pretty strong medication.

I'm behind three layers of firewalls (don't ask), and Larry definitely 
doesn't have full control over anything.

Did you think "kernel.bkbits.net" is my source tree? Dream on. My personal
source tree is on my own machine, nobody touches it but me. That's how I
have _always_ worked. The public ones are just random other repositories, 
they get pushed to by me and nobody else.

And I mean that "nobody else". If somebody else tried to push something
else than what is in my tree into them, I'd notice, because of how BK
works. My pushes just wouldn't _work_.

And you get a lot more data out of the kernel repostitory than you got
_before_ I was using BK, in a much more timely manner - even if you're not 
a BK user. You get tar-balls and patches every night, something that just 
wouldn't happen without a SCM that I liked.

> Give me a good reason, why he can deny me that rather simple request to 
> get some data out of the repository.

Give me _one_ good reason you think you have the right to anything more?

The alternative to me using BitKeeper would be patches and tar-balls. 
Which you already have. So why are you complaining? BK isn't taking 
anything away from you.. 

Since you seem to be blind to the problem, let's try it one more time. 

The BK license is _exactly_ the same issue as with the GPL. In the GPL, 
the rule is "tit for tat" - you get to play with the sources, but in 
exchange you have to give out your modifications. Some people complain 
about that, and I call them worthless whiners.

In the BK license, it's "tit for tat". You get to use Larry's program, in 
exchange for not competing with him. Some people complain about that, and 
I call them worthless whiners.

See the pattern? In both cases, the answer is: if you don't like it, don't 
use it. And in both cases, if you don't use it, you are no worse off than 
if it didn't exists, so it's not like the existence of GPL'd programs or 
BK is making your life any worse.

Sure, your life could be better if you accepted the rules. But that's the 
whole POINT of the rules. That's why the GPL works - people accept the 
fact that they have to make modifications available, because they think 
that it's worth it for them. Same is true of the BK users - they accept 
the license because they think it's worth it for them.

Or they don't. Their (your) choice. Don't whine to me or to Larry. It's
_your_ problem, and it is for _you_ to solve. Not me.

		Linus
