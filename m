Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSFTV7Z>; Thu, 20 Jun 2002 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSFTV7Y>; Thu, 20 Jun 2002 17:59:24 -0400
Received: from [195.63.194.11] ([195.63.194.11]:56070 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315734AbSFTV7X> convert rfc822-to-8bit; Thu, 20 Jun 2002 17:59:23 -0400
Message-ID: <3D125032.3040809@evision-ventures.com>
Date: Thu, 20 Jun 2002 23:59:14 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Cort Dougan <cort@fsmlabs.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206201428481.8225-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> 
> On Thu, 20 Jun 2002, Martin Dalecki wrote:
> 
>>Linus you forget one simple fact - a HT CPU is *not* two CPUs.
>>It is one CPU with a slightly better utilization of the
>>super scalar pipelines.
> 
> 
> Doesn't matter. It's SMP to software, _and_ it is a perfect example of how
> integration, in the form of almost free transistors, changes the
> economics.

Well but this simply still doesn't make SMP magically scale
better. HT gives you about 12% increase in throughput on average.
This will hardly increase your MP3 ripping expierence :-).

> Integration is _not_ "just another way".
> 
> Integration fundamentally changes the whole equation.
> 
> When you integrate the SMP capabilities on the CPU, suddenly the world
> changes, because suddenly SMP is cheap and easy to do for motherboard
> manufacturers that would never have done it before. Suddenly SMP is
> available at mass-market prices.

And suddenly the Chip-Set manufacturers start to buy CPU
designs like creazy, becouse they can see what will be next... of course.

> When you integrate multiple CPU's on one standard die (either HT or real
> CPU's), the same thing happens.

Again HT is still only one CPU. You are too software centric :-).

> When you start integrating crossbars etc "numa-like" stuff, like Hammer
> apparently is doing, you get the same old technology, but it _behaves_
> differently.

Yes HT gives 12%. naive SMP gives 50% and good SMP (aka corssbar bus)
gives 70% for two CPU. All those numbers are well below the level
where more then 2-4 makes hardly any sense... Amdahl bites you still if you
read it like:

88% waste (well actuall this time not)
50% waste
20% waste

on scale.

However corssbar switches are indeed allowing for maximally
64 CPUs and more importantly it's the first step since a long time
to provide better overall system throughput. However they will still
not be near any commodity - too much heat for the foreseeable future.

> You see this outside CPU's too.
> 
> When people started integrating high-performance 3D onto a single die, the
> _market_ changed. The way people used it changed. It's largely the same
> technology that has been around for a long time in visual workstations,
> but it's DIFFERENT thanks to low prices and easy integration into
> bog-standard PC's.
> 
> A 3D tech person might say that the technology is still the same.
> 
> But a real human will notice that it's radically different.

Yes but you can drive the technology only up to the perceptual limits
of a human. For example since about 6 years all those advancements
in the graphics area are largely uninterresting to me. I don't
play computer games. Never - they are too boring. Jet another
fan in my computer - no thank's.

> Did you mention that there are a lot more resistors in computers than
> CPU's? No. It is irrelevant. It doesn't drive technology in fundamental
> ways - even though the amount of fundamental technolgy inherent on a
> modern motherboard in _just_ the passive components like the resistor
> network is way beyond what people built just a few years ago.

Well the last real technological jump comparable to the invention
of television was actually due to this kind of CPUs which you
compare to microbes - mobiles :-). And well I'm awaiting the
day where there will be some WinWLAN card as shoddy as those Win
modems are... Fortunately they made 802.11b complicated enough :-)
But with a corssbar switch in place they could well make up for
the latency on the main CPU... oh fear... oh scare...





