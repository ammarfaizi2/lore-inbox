Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbTCFIIB>; Thu, 6 Mar 2003 03:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267919AbTCFIIB>; Thu, 6 Mar 2003 03:08:01 -0500
Received: from dsl-212-144-227-068.arcor-ip.net ([212.144.227.68]:19841 "EHLO
	VikingPC.home") by vger.kernel.org with ESMTP id <S267906AbTCFIH7>;
	Thu, 6 Mar 2003 03:07:59 -0500
Date: Thu, 6 Mar 2003 09:18:30 +0100
From: Corvus Corax <corvusvcorax@gemia.de>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux vs Windows temperature anomaly
Message-Id: <20030306091830.5a230e2d.corvusvcorax@gemia.de>
In-Reply-To: <3E66FF6B.2060301@wmich.edu>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>
	<p05210507ba8c20241329@[10.2.0.101]>
	<3E66842F.9020000@WirelessNetworksInc.com>
	<200303061038.44872.kernel@kolivas.org>
	<20030306081804.4717d1c4.corvusvcorax@gemia.de>
	<3E66FF6B.2060301@wmich.edu>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 06 Mar 2003 02:57:31 -0500
schrieb Ed Sweetman <ed.sweetman@wmich.edu>:

> This is getting kicked like a deadhorse by now i think but.
> 
even dead horses have the right of being kicked ;) but:

> 
> Unlike your cpu which gets idle commands from the OS and thus has an 
> idle loop where it turns off certain circuits and which can get acpi 
> commands to turn completely off the other chips in the computer do not 
> have such a luxury. they are always on like the cpus of yesteryear used 
> to be.  It doesn't matter if they have data moving in them or not, no 
> big difference.

I think this is not right so, doe to 2 reasons:

1st, i burned my finger on my bridge often enough that i should know that
its temperature varies, at least on some chips to really huge amounts ;-)
(on my new borad they dont even get hand warm)

2nd. the fact that the chip (or circuit) is on, doesnt mean that there flows current.

all halfway new microchips (including those bridges of course) are build in CMOS
or similar technology, meaning that there is no more static current flowing through
the transistors, but only capacity dependant current, when the transistors change
their state.

if no data flows, little transistors change their state
(only clock signals and some other idle work that is done),
and the output drivers to the bus systems are turned low.

so there is no static current on the bus and no dynamic current in the chip --> low overall current
--> low temperature

on the other hand if data flows, its being processed, and many transistors change their state with the data flow,
as do the output driver blocks --> high static and dynamic current --> high temperature.


> The reason why it seems like this is the case is for 
> you HSF cooled cpu guys, load on the system bus usually means high cpu 
> load and that means more heat put into the surrounding air and the 
> little usually passive cooled but regardless, less hot system bus gets 
> hotter along with the cpu and cooler when the cpu is idle.   People 
> cooled by other methods that do not dump heat into the surrounding air 
> inside the case will notice that the system bus temp only varies with 
> ambient air temp changes, not data transfer going on between ram and cpu.
> 

than this would be measurable as an higher mainboard or system temperature,
which is not in our case, as described in the other mails


greetings,


Corvus V Corax ;)
