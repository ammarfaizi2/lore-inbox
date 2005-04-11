Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVDKUz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVDKUz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVDKUz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:55:59 -0400
Received: from Nazgul.esiway.net ([193.194.16.154]:51690 "EHLO
	Nazgul.esiway.net") by vger.kernel.org with ESMTP id S261929AbVDKUy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:54:57 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Marco Colombo <marco@esi.it>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050411162514.GA11404@pegasos>
References: <1113235942.11475.547.camel@frodo.esi>
	 <20050411162514.GA11404@pegasos>
Content-Type: text/plain
Organization: ESI srl
Date: Mon, 11 Apr 2005 22:54:50 +0200
Message-Id: <1113252891.11475.620.camel@frodo.esi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 18:25 +0200, Sven Luther wrote:
> On Mon, Apr 11, 2005 at 06:12:22PM +0200, Marco Colombo wrote:
[...]
> > A - is the Author (or rights owner) of the software (GPL'ed);
> > B - is an user, who got the a copy of the software from A;
> > C - is another user, who got a copy indirectly, that is from a  
> >     distributor;
> > D - is the distributor C got the copy from.
[...]
> > Now. It seems to me that the relationship between D (distributor) and C
> > (target of the distribution) is _not_ regulated by GPL at all. GPL is a
> > license, the _owner_ of the rights (A) and the recipient of some rights
> > (C, as an user) are the only subjects. D _owns_ no rights on the
> > software, so can't grant any to C. There's no GPL between D and C.
> 
> I think you are missing the point. D get's a licence from A, the GPL, and this
> licence includes a licence, not on use, but on redistribution, and the act of
> D distributing the copy to C is covered by it. In a sense A allows D to
> distribute the software under the GPL to C. Now, D is only allowed to do this
> distribution if he also distribute the source code of it, which he can't do
> for the firmware. 

I think only a lawyer can answer here. What I'm saying is that the
license always comes from the copyright owner, that is A.
Sublicensing is not covered by GPL. Distribution is not sublicensing.
Quoting GPL itself:

6. Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions. ...

The wording is clear, the license is between A and C.
There's no license between D and C. There's no way C can enforce
anything on D (well, not on GPL basis).

> Notice also the fact that there are so many contributors to the linux kernel
> in effect means that there is nobody with the full rights as A, but only a
> multitude of people in the D case.

In this case, A is clearly the author (onwer of rights) of the firmware.
D is fine on respect of the other A's, since their source is actually 
(and clearly) there. It's the missing source case we're considering
and the number of A's is quite small, the copyright owners of firmware
images. Those A's are easily identified, and perfectly able to act.

> > So, even if C comes to think D is breaking GPL, all C can do is notify
> > A. The GPL D is supposedly breaking is an agreement between A and D
> > only. On which basis may C sue D? For breaking what agreement? It's up
> > to A to sue D for breaking GPL.
> 
> This is indeed an interpretation. I am not sure myself if a user receiving
> GPLed software in binary only fashion as is the case here can sue either D or
> A to get access to that source code.

The point is, if A states (even implicitly) D is distributing the right
source, there's nothing C can do to D. D is not breaking GPL, as long A
says so and it's A granting D the right to distribute. There's no way C
can prevent D from distributing A's software, if A is fine with it.
It's up to A to decide if GPL conditions are met by D.

Maybe mine it's only one interpretation. But I can't see any other.

> Now you could argue that any number of authors of GPLed bits of the linux
> kernel could sue D for distributing their software as a derived work of the
> binary-only bit, and the fact that D doesn't distribute the source code to the
> binary bit voids any other right allowed him by the GPL, and thus he has no
> right to do the distribution at all. The GPL is very clear on this topic.

We're not talking of that case. D _is_ actually distributing the right
source, according to A. It's C that is unsatisfied with it.

> > What is the risk for D, if D is distributing the source of the software
> > _exactly_ in the form A publicly provides it? It's not up to D to
> > produce the source, all D has to do is to provide verbatim copies of
> > it to anyone D distributes the software to, on request.
> 
> Imagine one of those companies got bought up by some predatory company who
> wishes us (linux, debian, redhat/suse, whoever) harm. They would then be able
> to sue for damage or prejudice or whatever. And given what i have heard about
> the uncertainities of the Alteon ownership, this seems indeed like a plausible
> scenario, which could result in a SCO bis case.

I'm not following. Are you saying what if A is bought? That is
different. Well GPL is quite clear:

1. You may copy and distribute verbatim copies of the Program's source
code as you receive it, ...

If D is distributing the source as received from A, D is in full
compliance. How could A sue D? If A distributed incomplete source
in the first place, it's not D's fault for sure. Do you really think
the following scenario is likely:

A to D: you must distribute the complete source, or the license will be
        terminated!
D to A: gimme the complete source, and I'll distribute it.
A to D: no, I'm not willing to give you the full source of my firmware,
        but you must distribute it anyway!

That, in court? Is this really what you're afraid of?
The outcome is, very likely A will be forced to release the full source.
(and D forced to distribute it, but all D's we're talking of here are
very happy with the full disclosure scenario, aren't they?)

> This is the scenario i want to avoid by explicitly stating the relationships
> of all copyright issues of those firmware blobs.

I don't see this scenario nowhere close to likely. Of course, A can 
always sue any B, C, or D for whatever reason. It's very unlikely
A will sue anyone in full compliance of GPL, but it's possible.
There's nothing we can do about it. But there's no reason to worry
either.

As for the matter of explicit copyright notices, I can only agree.
They won't harm for sure. From a purist standpoint, you're right. And
I _am_ a purist. B-) 

> > Does is really matter if C thinks the source being incomplete,
> > or missing? C can take the issue up with A (by means of the GPL that
> > exists between A and C), but not with D, since there's no GPL between
> > D and C. C is in the same position of B. If the source is incomplete,
> > they may ask A to comply to the GPL, but not D. D made no promises to
> > them.  
> 
> /me wonders if C then holds an illegal copy of the software, and can then be
> prosecuted for piracy :)

No, because GPL explicitly states that:

4. You may not copy, modify, sublicense, or distribute the Program
except as expressly provided under this License. Any attempt otherwise
to copy, modify, sublicense or distribute the Program is void, and will
automatically terminate your rights under this License. However, parties
who have received copies, or rights, from you under this License will
not have their licenses terminated so long as such parties remain in
full compliance.

Note also that GPL says nothing about how you get your copy. You can
get it while hanging from the ceiling ala Mission Impossible, but if
the software is GPL'ed, then your license is valid. The action may
still be illegal, but that's another matter: you _can_ use the software
(even if in jail). B-)

> 
> Friendly,
> 
> Sven Luther

Have a nice day,
.TM.

