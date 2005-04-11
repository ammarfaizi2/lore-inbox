Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVDKVOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVDKVOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVDKVOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:14:24 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.28]:14410 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261940AbVDKVNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:13:04 -0400
X-ME-UUID: 20050411211252683.A6D961C007DC@mwinf0309.wanadoo.fr
Date: Mon, 11 Apr 2005 23:07:54 +0200
To: Marco Colombo <marco@esi.it>
Cc: Sven Luther <sven.luther@wanadoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050411210754.GA11759@pegasos>
References: <1113235942.11475.547.camel@frodo.esi> <20050411162514.GA11404@pegasos> <1113252891.11475.620.camel@frodo.esi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1113252891.11475.620.camel@frodo.esi>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 10:54:50PM +0200, Marco Colombo wrote:
> In this case, A is clearly the author (onwer of rights) of the firmware.
> D is fine on respect of the other A's, since their source is actually 
> (and clearly) there. It's the missing source case we're considering
> and the number of A's is quite small, the copyright owners of firmware
> images. Those A's are easily identified, and perfectly able to act.

Well, i am not sure with your interpretation, but even if you where right, we
have no guarantee that A will continue being lenient, and no guarantee that A
will not start suing D or whoever for illegally distributing his stuff without
sources.

> > > So, even if C comes to think D is breaking GPL, all C can do is notify
> > > A. The GPL D is supposedly breaking is an agreement between A and D
> > > only. On which basis may C sue D? For breaking what agreement? It's up
> > > to A to sue D for breaking GPL.
> > 
> > This is indeed an interpretation. I am not sure myself if a user receiving
> > GPLed software in binary only fashion as is the case here can sue either D or
> > A to get access to that source code.
> 
> The point is, if A states (even implicitly) D is distributing the right
> source, there's nothing C can do to D. D is not breaking GPL, as long A

So, i get some random bit of GPLed software, i add a module or some code to
it, i distribute that code in binary format only, and claim that i have used
an hex editor to write it, or simply that it is the 'right' source.

I have some serious doubts that i will not get sued by all the authors of the
original GPLed work if i were to do that, and rightly so.

> says so and it's A granting D the right to distribute. There's no way C
> can prevent D from distributing A's software, if A is fine with it.
> It's up to A to decide if GPL conditions are met by D.

Even in that case, you still need explicit permission of A, and all the other
copyright holders of the rest of the GPLed work, to give you an explicit
exception to link with this non-free bit of code.

> Maybe mine it's only one interpretation. But I can't see any other.
> 
> > Now you could argue that any number of authors of GPLed bits of the linux
> > kernel could sue D for distributing their software as a derived work of the
> > binary-only bit, and the fact that D doesn't distribute the source code to the
> > binary bit voids any other right allowed him by the GPL, and thus he has no
> > right to do the distribution at all. The GPL is very clear on this topic.
> 
> We're not talking of that case. D _is_ actually distributing the right
> source, according to A. It's C that is unsatisfied with it.

No. The source code is clearly the prefered form of modification, not some
random intermediate state A may be claiming is source.

> > > What is the risk for D, if D is distributing the source of the software
> > > _exactly_ in the form A publicly provides it? It's not up to D to
> > > produce the source, all D has to do is to provide verbatim copies of
> > > it to anyone D distributes the software to, on request.
> > 
> > Imagine one of those companies got bought up by some predatory company who
> > wishes us (linux, debian, redhat/suse, whoever) harm. They would then be able
> > to sue for damage or prejudice or whatever. And given what i have heard about
> > the uncertainities of the Alteon ownership, this seems indeed like a plausible
> > scenario, which could result in a SCO bis case.
> 
> I'm not following. Are you saying what if A is bought? That is
> different. Well GPL is quite clear:
> 
> 1. You may copy and distribute verbatim copies of the Program's source
> code as you receive it, ...
> 
> If D is distributing the source as received from A, D is in full
> compliance. How could A sue D? If A distributed incomplete source
> in the first place, it's not D's fault for sure. Do you really think
> the following scenario is likely:
> 
> A to D: you must distribute the complete source, or the license will be
>         terminated!
> D to A: gimme the complete source, and I'll distribute it.
> A to D: no, I'm not willing to give you the full source of my firmware,
>         but you must distribute it anyway!

The result is that the code in question has to be stopped from being
distributed by D. But the case here is different, since A is not the sole
copyright owner, so he doesn't get to set random interpretations of what is
source code. 

> That, in court? Is this really what you're afraid of?
> The outcome is, very likely A will be forced to release the full source.
> (and D forced to distribute it, but all D's we're talking of here are
> very happy with the full disclosure scenario, aren't they?)

Imagine A refusing to give away the source code, and D is ordered to remove
the incriminated code it is illegally distributing from all its servers, and
recall all those thousands of CD and DVD isos containing the code it
distributed, and being fined for each day it doesn't do so ? 

> > This is the scenario i want to avoid by explicitly stating the relationships
> > of all copyright issues of those firmware blobs.
> 
> I don't see this scenario nowhere close to likely. Of course, A can 
> always sue any B, C, or D for whatever reason. It's very unlikely
> A will sue anyone in full compliance of GPL, but it's possible.
> There's nothing we can do about it. But there's no reason to worry
> either.

So, we don't take the risk and don't distribute it. If A is not ready to put a
couple of lines of disclaimer on his work explaining the copyright and
licencing issues, then we are better of not distributing its code, which is
what debian will do.

> As for the matter of explicit copyright notices, I can only agree.
> They won't harm for sure. From a purist standpoint, you're right. And
> I _am_ a purist. B-) 

:)

> > > Does is really matter if C thinks the source being incomplete,
> > > or missing? C can take the issue up with A (by means of the GPL that
> > > exists between A and C), but not with D, since there's no GPL between
> > > D and C. C is in the same position of B. If the source is incomplete,
> > > they may ask A to comply to the GPL, but not D. D made no promises to
> > > them.  
> > 
> > /me wonders if C then holds an illegal copy of the software, and can then be
> > prosecuted for piracy :)
> 
> No, because GPL explicitly states that:
> 
> 4. You may not copy, modify, sublicense, or distribute the Program
> except as expressly provided under this License. Any attempt otherwise
> to copy, modify, sublicense or distribute the Program is void, and will
> automatically terminate your rights under this License. However, parties
> who have received copies, or rights, from you under this License will
> not have their licenses terminated so long as such parties remain in
> full compliance.

Yeah, but who know what mad laws will be passed to repress piracy which will
make this void.

> Note also that GPL says nothing about how you get your copy. You can
> get it while hanging from the ceiling ala Mission Impossible, but if
> the software is GPL'ed, then your license is valid. The action may
> still be illegal, but that's another matter: you _can_ use the software
> (even if in jail). B-)

I am not sure. If i where to get a copy of windows, and manage to install it
without clicking on the "i agree" button, does that make it a legal copy of
windows to use ? 

Friendly,

Sven Luther

