Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S284467AbRLIVtz>; Sun, 9 Dec 2001 16:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S284469AbRLIVtq>; Sun, 9 Dec 2001 16:49:46 -0500
Received: from mx3.port.ru ([194.67.57.13]:44810 "EHLO smtp3.port.ru") by vger.kernel.org with ESMTP id <S284467AbRLIVtf>; Sun, 9 Dec 2001 16:49:35 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200112092150.fB9Lot906422@vegae.deep.net>
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
To: hahn@physics.mcmaster.ca (Mark Hahn)
Date: Mon, 10 Dec 2001 00:50:55 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112091619190.6428-100000@coffee.psychology.mcmaster.ca> from "Mark Hahn" at Dec 09, 2001 04:21:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Mark Hahn wrote:"
> 
> > > I had an AMD K6 200 with an ISA NE2K card whan I started using Linux...
> ...
> >   such broken behaviour.
> 
> the only thing broken is that the nic is pitiful and eats CPU.
> 
> >     i`ve made a further research and discovered the fact that
> > 	ping -l 99999999 		- does not corrupt the sound
> > 	ping -l 99999999 -s 256		- does not corrupt the sound
> > 	ping -l 99999999 -s 512		- significantly corrupts the sound
> > 	ping -l 99999999 -s 16384 	- heavily corrupts the sound with stalls
> 
> right, so more fragmentation-assembly increases the CPU load,
> no surprise there.
    damn, i have a mtu of 1500 and i dont quite see abt what frag/reassembly
   are you talking about while the problems start to pop out on _256_ bytes
   large packets (yes 256+smth like 32 or more)
> 
> >     My thinking is that if 2.0 was better than 2.4 in this case, we definitely
> >    need to find out why was it so and use its strong side.
> 
> your particular case is not worth fixing; I doubt it applies to machines
> with modern CPU, modern dram, modern nics.
> 
> 
   but why? 2.0 is ok, 2.4 is broken.

   look: we have 2.0 serving NIC interrupts more efficintly than 2.4, and you
   say that we even dont need to know _why_ its so!?

   why do you neglect the possible improvement of that case?

cheers, Samium Gromoff
