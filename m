Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbSKOLtF>; Fri, 15 Nov 2002 06:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSKOLtF>; Fri, 15 Nov 2002 06:49:05 -0500
Received: from host2.spirecom.net ([209.239.40.62]:4614 "EHLO
	host2.spirecom.net") by vger.kernel.org with ESMTP
	id <S265249AbSKOLtD>; Fri, 15 Nov 2002 06:49:03 -0500
From: "Alastair MacGregor" <ali@nitrotech.co.uk>
To: "'David Crooke'" <dave@convio.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Dual athlon XP 1800 problems
Date: Fri, 15 Nov 2002 11:55:49 -0000
Message-ID: <008301c28c9d$f5e4c580$0600a8c0@analogue>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <3DD4CD06.2010009@convio.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't know about the kernel issues your experiencing but I have that
board and the BIOS does seem a bit flaky - I can confirm however that
the temperature monitoring as you noticed doesn't give sane readings
until you hit update for the first time.

I have Dual Athlon MP 1.2Ghz, 768MB crucial ECC RAM and kernel 2.4.19
optimized for athlonmp using gentoo patches and its solid as a rock.
The only problems I've had were full lock-ups when compiling but I
traced that to a faulty dimm module.

Cheers
ali

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of David Crooke
> Sent: 15 November 2002 10:32
> To: linux-kernel@vger.kernel.org
> Subject: Re: Dual athlon XP 1800 problems
> 
> 
> Not sure if this is an apposite list, but found this thread ....
> apologise in advance.
> 
> I just built a similar dual AMD machine tonight and it also has
> issues....... never used any AMD stuff before so venturing into new
turf.
> 
> Tyan S2460  - motherboard sticker says "C", BIOS rev 1.03
> 2 x Athlon MP 2000+ (1666 MHz) - retail packaged, AMD clip-on
heatsinks
> and fans
> 1Gb PC2100 ECC registered memory (2 x 512Mb DIMMs, Kingston branded)
> Red Hat 7.2 but downloaded and built 2.4.19, configured for SMP,
Athlon
> target
> Single IDE drives, no RAID or stuff like that
> Tekram DC390 (8 bit SCSI)
> 3Com Cyclone 3C905
> D-Link DE-590TX (??) - uses ne2k-pci driver, has worked since early
> 2.0.x and probably before
> ATI Rage 3D Pro (AGP 2x)
> 
> Big Antec case with a ton of fans :-)
> 
> 1. When I first put it together, it would consistenly run OK for a
> period of 4-5 minutes, quite precisely - no less than 4, no more than
5
> and then just lock up HARD - no Ctrl-Alt-Del, no kernel panics,
nothing.
> Once or twice it seemed like it stuttered - as if the load was like
> 10.00 or higher, the keystroke echo would take 2-3 seconds.
> 
> 2. First try - I pulled the Tekram (it's ancient and has bootable
BIOS)
> - no difference
> 
> 3. Tried some BIOS settings (e.g. SMP 1.1 mode) - it DOES NOT like
this;
> any BIOS changes AT ALL (even seemingly harmless ones like Num Lock)
> appear to mess it up totally, and LILO hangs at "LI" when trying to
> start. Restored factory defaults.
> 
> 4. Then I noticed that the CPU1 heatsink was quite warm (maybe 70C
> feeling around the thick bit of the aluminium) whereas CPU0 heatsink
is
> just above room temp.
> 
> 5. Checking the Winbond monitoring in the BIOS** menu, it comes up
> showing both CPU's at 77C, then as you hit keys it takes proper
> readings, and claims both CPUs within 1-2 degrees of each other (??).
It
> seems accurate on fan speeds though. Both fans running pretty fast,
> 5500-6200 RPM.
> 
> 6. Pulled CPU1, messed around some - same behaviour, lock ups after
4-5
> mins
> 
> 7. Brought it up to single user mode console, to see if it was video
> card etc. - did some testing of just letting it mostly idle (while
true
> - uptime - sleep 1 - etc.) and locked up 1-2 more times.
> 
> 8. Rebooted again, now it's up and running and appears stable (still 1
> CPU), so I took it up to full init 5 and it stayed up (and so I'm
> writing this email :-)  Once or twice seemed to stall again for 1-2
> seconds (interrupt storm ???) but recovered.
> 
> Anyone have suggestions? I'm thinking to leave it running and see if
it
> stays up. Smells of a hardware issue, but also the BIOS seems a bit
> funny (there is a message in the Help which says "this setting for
debug
> only - remove for production" !!)
> 
> Other observation, possibly unrelated: the unpacking of the kernel
seems
> very slow for an otherwise pretty quick machine - the dots when it
says
> "Loading xxx..." tick at about 1 per second, much like a laptop with
> PC-66 memory, compared with 4-5 per second for the Pentium III
> 800/PC-133 motherboard I just hauled out.
> 
> 
> 
> 
> ** The temperature sensor driver stuff didn't seem to come with the
> kernel ??
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

