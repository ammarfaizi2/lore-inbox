Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290672AbSAYQLI>; Fri, 25 Jan 2002 11:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290712AbSAYQKw>; Fri, 25 Jan 2002 11:10:52 -0500
Received: from skiathos.physics.auth.gr ([155.207.123.3]:22516 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S290672AbSAYQKo>; Fri, 25 Jan 2002 11:10:44 -0500
Date: Fri, 25 Jan 2002 18:10:35 +0200 (EET)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <1011972717.22707.42.camel@psuedomode>
Message-ID: <Pine.GSO.4.21.0201251802491.19355-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Jan 2002, Ed Sweetman wrote:
> 
> I was getting at this earlier. Though the Athlon XP's are much better
> power-wise than the earlier athlon's.  I wouldn't suggest doing it to
> any athlon under XP. But then again, the XP is supposed to have

I reckon a >1600MHz XP (1800+) has about the same or more power than the
1400MHz T-bird. So it should basically be the same regarding the
STPGNT/disconnect.

> something similar to clock stepping to gradually move from full power to
> lower power, which decreases mechanical stress and psu stress.  I

I guess this is the PowerNOW! feature of the mobile Athlons/Durons with
the Palomino core. I think this is totaly different than STPGNT. And this
would be worth implementing if it can be supported on desktop Athlon/Duron
models/mobos.

Anybody has more info about this?


> remember when the same concerns were brought over the HLT idle trick but
> obviously the HLT instruction isn't harmful enough.  Would be nice to
> look at the latencies with say, Robert Love's preempt stat patch of a
> kernel running with no power management, then with HLT, then with the
> vcl patch.

True. Although an tv tunner card output on screen tells the tale pretty
well :-)

> Nice rule of thumb though.   If your cpu _ever_ gets into the 50C range
> your case and or hsf is not efficient enough for your hardware. Anything
> above 50 and you're shortening the life of the cpu. Relying on idle
> tricks isn't going to help you.  

I hope everybody could see it this way.

-K.


