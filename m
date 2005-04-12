Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVDLAl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVDLAl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVDLAl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:41:27 -0400
Received: from Nazgul.esiway.net ([193.194.16.154]:9867 "EHLO
	Nazgul.esiway.net") by vger.kernel.org with ESMTP id S261992AbVDLAkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:40:49 -0400
Date: Tue, 12 Apr 2005 02:40:48 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Sven Luther <sven.luther@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
In-Reply-To: <20050411210754.GA11759@pegasos>
Message-ID: <Pine.LNX.4.61.0504120034490.27766@Megathlon.ESI>
References: <1113235942.11475.547.camel@frodo.esi> <20050411162514.GA11404@pegasos>
 <1113252891.11475.620.camel@frodo.esi> <20050411210754.GA11759@pegasos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005, Sven Luther wrote:

> On Mon, Apr 11, 2005 at 10:54:50PM +0200, Marco Colombo wrote:
>> In this case, A is clearly the author (onwer of rights) of the firmware.
>> D is fine on respect of the other A's, since their source is actually
>> (and clearly) there. It's the missing source case we're considering
>> and the number of A's is quite small, the copyright owners of firmware
>> images. Those A's are easily identified, and perfectly able to act.
>
> Well, i am not sure with your interpretation, but even if you where right, we
> have no guarantee that A will continue being lenient, and no guarantee that A
> will not start suing D or whoever for illegally distributing his stuff without
> sources.

Let's keep things separated. I'm saying that the only one that may
sue D is A, not C. If we agree on this, we may abandon the case of a third
party sueing D.

As for threats coming from A, IMHO D is safe as long as he distributes
what A claims the source is, even if it's a hex string. In no world
A can publicly state "this is the source" and then sue D because
"no, that's not the source" (assuming D is copying it verbatim).

>>>> So, even if C comes to think D is breaking GPL, all C can do is notify
>>>> A. The GPL D is supposedly breaking is an agreement between A and D
>>>> only. On which basis may C sue D? For breaking what agreement? It's up
>>>> to A to sue D for breaking GPL.
>>>
>>> This is indeed an interpretation. I am not sure myself if a user receiving
>>> GPLed software in binary only fashion as is the case here can sue either D or
>>> A to get access to that source code.
>>
>> The point is, if A states (even implicitly) D is distributing the right
>> source, there's nothing C can do to D. D is not breaking GPL, as long A
>
> So, i get some random bit of GPLed software, i add a module or some code to
> it, i distribute that code in binary format only, and claim that i have used
> an hex editor to write it, or simply that it is the 'right' source.
>
> I have some serious doubts that i will not get sued by all the authors of the
> original GPLed work if i were to do that, and rightly so.

No. Please don't throw irrelevant matters in. D is not modifing the
software at all. D is a mere distributor. We're not addressing issues
related to modification, since no one is going to modify the firmware
anyway. This is not a general discussion on GPL. Issues related to
modification do not belong to this thread, which already very close
to off topic on l-k.

Which reminds me. The only reason why this thread belongs here, IMHO,
it's because when it comes to GPL, it really doesn't matter what
FSF's interpretation is, or anyone else's. The authors are choosing
GPL as a license, so _thier_ interpretation is what really matters.

>> says so and it's A granting D the right to distribute. There's no way C
>> can prevent D from distributing A's software, if A is fine with it.
>> It's up to A to decide if GPL conditions are met by D.
>
> Even in that case, you still need explicit permission of A, and all the other
> copyright holders of the rest of the GPLed work, to give you an explicit
> exception to link with this non-free bit of code.

Yes, but it does not apply to our case here. There's no "all other
copyright holders". _You_ stated that the firmware is included by mere
aggregation, so there's no other holders involved. We're talking
about the firmware case. A is one or two well identified subjects.
And A wrote it is GPL'ed. Whether you agree or not, that's the licence
A chose. A placed the copyright notice.

The licence is a matter between A and D. A may sue D and D may (less
likely) sue A, if conditions are not met. I'm not sure at all GPL
is enforceable by D upon A. Let's assume it is, for sake of discussion,
anyway.

>>> Now you could argue that any number of authors of GPLed bits of the linux
>>> kernel could sue D for distributing their software as a derived work of the
>>> binary-only bit, and the fact that D doesn't distribute the source code to the
>>> binary bit voids any other right allowed him by the GPL, and thus he has no
>>> right to do the distribution at all. The GPL is very clear on this topic.
>>
>> We're not talking of that case. D _is_ actually distributing the right
>> source, according to A. It's C that is unsatisfied with it.
>
> No. The source code is clearly the prefered form of modification, not some
> random intermediate state A may be claiming is source.

In this context, it is. Only A may sue D for not distributing the source.
Whatever D distributes, D has to make A happy. If A is happy with D
distributing `dd if=/dev/random count=1` as source, no one can stop D
from doing that. Keep in mind A is the copyright holder. He grants
rights to third parties. No one but A can remove them.

[...]
>> I'm not following. Are you saying what if A is bought? That is
>> different. Well GPL is quite clear:
>>
>> 1. You may copy and distribute verbatim copies of the Program's source
>> code as you receive it, ...
>>
>> If D is distributing the source as received from A, D is in full
>> compliance. How could A sue D? If A distributed incomplete source
>> in the first place, it's not D's fault for sure. Do you really think
>> the following scenario is likely:
>>
>> A to D: you must distribute the complete source, or the license will be
>>         terminated!
>> D to A: gimme the complete source, and I'll distribute it.
>> A to D: no, I'm not willing to give you the full source of my firmware,
>>         but you must distribute it anyway!
>
> The result is that the code in question has to be stopped from being
> distributed by D. But the case here is different, since A is not the sole
> copyright owner, so he doesn't get to set random interpretations of what is
> source code.

Definitely I'm not following. How can D be ordered to stop distributing
the software if A refuses to give the source? A is in violation. And
even if GPL can't be enforced that way, by no means D is in violation
when it's A that it's preventing D from complying.

The only way this can work the way you say is if A and D had a private
agreement, and no proof can be made by D this agreement ever existed.

But A released the software in public, and GPL'ed it. If A wants to keep
part of the source obscured, he had better to stay well away from any
court.

>> That, in court? Is this really what you're afraid of?
>> The outcome is, very likely A will be forced to release the full source.
>> (and D forced to distribute it, but all D's we're talking of here are
>> very happy with the full disclosure scenario, aren't they?)
>
> Imagine A refusing to give away the source code, and D is ordered to remove
> the incriminated code it is illegally distributing from all its servers, and
> recall all those thousands of CD and DVD isos containing the code it
> distributed, and being fined for each day it doesn't do so ?

Sorry, this is nonsense. D is well willing to distribute the source.
In this case, he _is_ distributing what A publicly stated to be the source.
That's all. You say what if A changed his mind about what the source is?
Well since it's still GPL'ed (we agree A can't chance the licence on the
fly, right?) A is to provide the new, complete version of the source.
Then, if and only if D refuses to distribute _that_ source, D is in
violation. GPL requires D to distribute source _as received by A_.
If A refuses to give the source, the specific requirement is not
enforceable.

>>> This is the scenario i want to avoid by explicitly stating the relationships
>>> of all copyright issues of those firmware blobs.
>>
>> I don't see this scenario nowhere close to likely. Of course, A can
>> always sue any B, C, or D for whatever reason. It's very unlikely
>> A will sue anyone in full compliance of GPL, but it's possible.
>> There's nothing we can do about it. But there's no reason to worry
>> either.
>
> So, we don't take the risk and don't distribute it. If A is not ready to put a
> couple of lines of disclaimer on his work explaining the copyright and
> licencing issues, then we are better of not distributing its code, which is
> what debian will do.

There no such a risk. A already placed a copyright notice on his work.
Is it the wrong one? Who cares? I'd even say that once he released it
under GPL, he can't take it back.

This is a close to impossible scenario, so why worry about it?
Anyone may sue you because he doesn't like your name. Or you logo.
Or the name of your server. The risk is by no means lower than the
case you pictured. Why not stopping being debian at all, then?

[...]
> Yeah, but who know what mad laws will be passed to repress piracy which will
> make this void.

Oh, that's totally another matter. I'm not ever sure GPL is a valid
licence for software here in Italy as regards to our anti-piracy law.
Which is criminal law.

>> Note also that GPL says nothing about how you get your copy. You can
>> get it while hanging from the ceiling ala Mission Impossible, but if
>> the software is GPL'ed, then your license is valid. The action may
>> still be illegal, but that's another matter: you _can_ use the software
>> (even if in jail). B-)
>
> I am not sure. If i where to get a copy of windows, and manage to install it
> without clicking on the "i agree" button, does that make it a legal copy of
> windows to use ?

Come on, please, do not mix things up. I've said GPL'ed software. Last time
I checked, Windows was not GPL'ed (yet). :-)

> Friendly,
>
> Sven Luther

Have a nice day,
.TM.
-- 
       ____/  ____/   /
      /      /       /			Marco Colombo
     ___/  ___  /   /		      Technical Manager
    /          /   /			 ESI s.r.l.
  _____/ _____/  _/		       Colombo@ESI.it
