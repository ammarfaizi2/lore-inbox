Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbTCFIrh>; Thu, 6 Mar 2003 03:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTCFIrh>; Thu, 6 Mar 2003 03:47:37 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:28340 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S267104AbTCFIrf>;
	Thu, 6 Mar 2003 03:47:35 -0500
Message-ID: <3E670D9E.6060604@wmich.edu>
Date: Thu, 06 Mar 2003 03:58:06 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030206
MIME-Version: 1.0
To: Corvus Corax <corvusvcorax@gemia.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux vs Windows temperature anomaly
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>	<p05210507ba8c20241329@[10.2.0.101]>	<3E66842F.9020000@WirelessNetworksInc.com>	<200303061038.44872.kernel@kolivas.org>	<20030306081804.4717d1c4.corvusvcorax@gemia.de>	<3E66FF6B.2060301@wmich.edu> <20030306091830.5a230e2d.corvusvcorax@gemia.de>
In-Reply-To: <20030306091830.5a230e2d.corvusvcorax@gemia.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corvus Corax wrote:
> Am Thu, 06 Mar 2003 02:57:31 -0500
> schrieb Ed Sweetman <ed.sweetman@wmich.edu>:
> 
> 
>>This is getting kicked like a deadhorse by now i think but.
>>
> 
> even dead horses have the right of being kicked ;) but:
> 
> 
>>Unlike your cpu which gets idle commands from the OS and thus has an 
>>idle loop where it turns off certain circuits and which can get acpi 
>>commands to turn completely off the other chips in the computer do not 
>>have such a luxury. they are always on like the cpus of yesteryear used 
>>to be.  It doesn't matter if they have data moving in them or not, no 
>>big difference.
> 
> 
> I think this is not right so, doe to 2 reasons:
> 
> 1st, i burned my finger on my bridge often enough that i should know that
> its temperature varies, at least on some chips to really huge amounts ;-)
> (on my new borad they dont even get hand warm)
> 
> 2nd. the fact that the chip (or circuit) is on, doesnt mean that there flows current.
> 
> all halfway new microchips (including those bridges of course) are build in CMOS
> or similar technology, meaning that there is no more static current flowing through
> the transistors, but only capacity dependant current, when the transistors change
> their state.
> 
> if no data flows, little transistors change their state
> (only clock signals and some other idle work that is done),
> and the output drivers to the bus systems are turned low.
> 
> so there is no static current on the bus and no dynamic current in the chip --> low overall current
> --> low temperature
> 
> on the other hand if data flows, its being processed, and many transistors change their state with the data flow,
> as do the output driver blocks --> high static and dynamic current --> high temperature.
> 
> 
> 
>>The reason why it seems like this is the case is for 
>>you HSF cooled cpu guys, load on the system bus usually means high cpu 
>>load and that means more heat put into the surrounding air and the 
>>little usually passive cooled but regardless, less hot system bus gets 
>>hotter along with the cpu and cooler when the cpu is idle.   People 
>>cooled by other methods that do not dump heat into the surrounding air 
>>inside the case will notice that the system bus temp only varies with 
>>ambient air temp changes, not data transfer going on between ram and cpu.
>>
> 
> 
> than this would be measurable as an higher mainboard or system temperature,
> which is not in our case, as described in the other mails

higher than what, the bus power output is constant, the internal 
temperature of the case is dictated by the heat given off by all the 
components, they're not separable.  That's like saying i would be able 
to tell if my cpu is putting a constant power output by seeing a higher 
ambient air temp in the computer case...well no you wouldn't it becomes 
a constant and all the other components that do have varying power 
outputs dictate the fluctuations of ambient air. How you get a constant 
as contributing to changes in ambient air is beyond me, and finding a 
comparison in order to say it makes the air hotter is further beyond me. 
The ambient air temp is the temp it is because of all the components 
inside the case, including the system bus. The only way the system bus's 
power output would be able to be measured as a higher ambient air temp 
is if it worked the way you suggested (which i really dont think most 
do).  If you mean then the system bus should be hotter if it's always on 
the way i suggest ...well you'd be wrong.  They dont get hot if the 
ambient temperature around the bus's heatsink stays cool. Most people 
just run them passive when they have watercooling because without all 
the heat from the cpu's heatsink, the ambient air around the bus is 
sufficiently cool. otherwise a fan is usually needed.

i know for a fact my abit athlon motherboard's bus chip doesn't change 
temperature due to load in the system.  The only time it fluctuates is 
when the temperature of the room changes and that change is not due to 
the chip (unless i got no air circulation in the room then the computer 
as a whole will heat up all the air and that feeds back on itself)

I believe the originator of the thread went back to check and see if he 
can find out exactly what his Windows drivers are enabling.  the rest of 
the thread has been arguing over if linux can load hardware more than 
windows  can and what puts off heat and what doesn't which is stupid.

i think the topic of the thread is a bunch of BS because unless he has a 
driver that is for some reason changing the frequency of something or 
the voltage then linux is not going to stress the system more than 
windows. The whole thing wreaks of FUD whether intentional or not.

> greetings,
> 
> 
> Corvus V Corax ;)
> -

