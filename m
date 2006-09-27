Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWI0R25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWI0R25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbWI0R25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:28:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030471AbWI0R24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:28:56 -0400
Date: Wed, 27 Sep 2006 10:28:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <1159359540.11049.347.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <1159319508.16507.15.camel@sipan.sipan.org>  <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
  <1159342569.2653.30.camel@sipan.sipan.org>  <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
 <1159359540.11049.347.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ This is not so much really a reply to Alan, as a rant on some of the 
  issues that Alan takes up ]

On Wed, 27 Sep 2006, Alan Cox wrote:

> Ar Mer, 2006-09-27 am 10:58 +0200, ysgrifennodd Jan Engelhardt:
> > I think Linus once said that he does not consider the kernel to 
> > become part of a combined work when an application uses the kernel.
> 
> COPYING top of the kernel source tree.

Yes. But also somethign much more fundamental:

	Copyright Law - regardless of country

You can claim anything you damn well want in a license, but in the end, 
it's all about "derived works". If something is not a derived work, it 
doesn't matter _what_ ownership rights you have, it's simply not an issue.

So even if the kernel had a big neon sign that said "You're bound by this 
license in user space too!" (or, more likely, didn't have a sign at all, 
like was the case originally), that has absolutely _zero_ legal meaning 
for a copyright license. A license cannot cover something just because it 
"says so".

For example, I could write a copyright license that said

	"This license forbids you from ever copying the kernel, or any 
	work made by Leo Tolstoy, which is just a pseudonym for the
	easter bunny"

and the fact that the license claims to control the works of Leo "the 
easter bunny" Tolstoy, claiming so simply doesn't make it so.

And yes, the above is obviously ridiculous, but the point is, it's no more 
ridiculous than a license that would claim that it extends to programs 
just because you can run then on Linux.

In fact, it's also no more ridiculous than a license that claims it 
extends copyright the other way - to the hardware or platform that you run 
a program on. From a legal standpoint, such wording is just totally 
idiotic.

[ So the wording at the top of the license is a clarification of fact, not 
  really any kind of change of the license itself. It actually does have 
  some legal meaning (it shows "intent"), but most importantly it allows 
  people to not have to even worry about frivolous lawsuits. Nobody can 
  sue people for not running GPLv2 user-space through normal system calls, 
  because the statement of intent makes it clear that a judge would throw 
  out such a suit immediately.

  So I think the important thing here to take away is that "frivolous" 
  part of the lawsuit. The language doesn't actually _change_ the legal 
  meaning, but it protects against idiots. And a lot of lawyers worry 
  about idiots and money-grubbing douchebags *cough*SCO*cough*, and
  as such obvious clarifications _can_ be useful. ]

Another real-world example of this mis-understanding is that a lot of 
people seem to think that the GPLv2 disallows "linking" with non-GPLv2 
code. Almost everybody I ever meet say that, and the FSF has written long 
pieces on shared libraries etc.

People don't have a clue!

The GPLv2 never _ever_ mentions "linking" or any other technical measure 
at all. Doing so would just be stupid (another problem with the GPLv3, 
btw). So people who think that the GPLv2 disallows "linking" with 
non-GPLv2 code had better go back and read the license again.

Grep for it, if you want to. The word "link" simply DOES NOT EXIST IN THE 
LICENSE!

(It does exist at the end of the _file_ that contains the license, but 
that's not actually the license at all, it's just the "btw, this is how 
you might _use_ the license", and while legally that can be used to show 
"intent", it does not actually extend the copyright in the work in any 
way, shape, or form).

What the GPLv2 actually talks about is _only_ about "derived work". And 
whether linking (dynamically, statically, or by using an army of worker 
gnomes that re-arrange the bits to their liking) means something is 
"derived or not" is a totally different issue, and is not something you 
can actually say one way or the other, because it will depend on the 
circumstances.

I'm always surprised by how many people talk abut the GPLv2 (and, quite 
frankly, about the GPLv3 draft) without actually seemingly having ever 
read the damn thing, or, more likely, ever really understood any legal 
stuff what-so-ever, or the difference between the _use_ of a license, and 
the license itself.

For example, in the GPLv3 discussions, I've seen more than one person 
claim that I've used a special magic version of the GPLv2 that doesn't 
have the "v2 or any later" clause. Again, those people don't have a _clue_ 
about what they are talking about. They feel very free in arguing about 
other peoples copyrigted works, and the fact that I'm not a lawyer, but 
then they ignore the fact that I actually _do_ know what I'm talking 
about, and that they don't have a stinking clue.

> No. The definition of a derivative work is a legal one and not a
> technical one.

Exactly. A lot of people don't understand this, and a lot of people think 
that "derivative" means "being close". Linking doesn't make something 
derivative per se - the same way _not_ linking doesn't make it not be 
derivative.

Now, it is also indisputable that if you _need_ to "link", it's a damn 
good sign that something is _very_likely_ to be derivative, but as Alan 
points out, you could do the same thing with RPC over a socket, and the 
fact that you did it technically differently really makes no real 
difference. So linking per se isn't the issue, and never has been.

			Linus
