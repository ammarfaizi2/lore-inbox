Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288498AbSADFbt>; Fri, 4 Jan 2002 00:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288499AbSADFbk>; Fri, 4 Jan 2002 00:31:40 -0500
Received: from lsanca1-ar27-4-63-187-072.vz.dsl.gtei.net ([4.63.187.72]:9603
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S288498AbSADFba>; Fri, 4 Jan 2002 00:31:30 -0500
Date: Thu, 3 Jan 2002 21:31:03 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Thomas Gschwind <tom@infosys.tuwien.ac.at>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: i810_audio]
In-Reply-To: <20020103154718.C32419@infosys.tuwien.ac.at>
Message-ID: <Pine.LNX.4.33.0201032122510.505-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I took have problems recording. I'm using the i810 driver
in 2.4.16

I can do:

cat < /dev/sound/dsp > /dev/sound/dsp

and get a few seconds delayed echo of what is going on, as I would expect.

However, if I try to use anything more complicated, it locks up my system
- no keyboard, no network, needs to be hard booted.

The programs I have tried are "rec" which comes with sox-12.17.1 and a
downloaded utility called voice chat.

What happens is: the recording happens, but when the program ends, either
by itself or by being killed, the system locks up.

So maybe this is something to do with restoring settings at the end of the
recording?

Playback happens with no problem.

Below is the lspci output for the sound system, if it is of any use.

If there is any more info anyone wants, please ask.



00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device
2445 (rev 11)
        Subsystem: Compaq Computer Corporation: Unknown device 008c
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 0: I/O ports at 2000 [size=256]
        Region 1: I/O ports at 2400 [size=64]



-- 
Ben Clifford     benc@hawaga.org.uk
http://www.hawaga.org.uk/ben/  GPG: 30F06950
(310) 443 4485 (United States)     0709-227-5268 (United Kingdom)
telnet/ssh guest@barbarella.hawaga.org.uk password guest to talk
webcam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi
Job Required - Will do most things unix or IP for money.



