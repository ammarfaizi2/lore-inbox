Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSLZDav>; Wed, 25 Dec 2002 22:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSLZDav>; Wed, 25 Dec 2002 22:30:51 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:52498 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S262207AbSLZDaq>; Wed, 25 Dec 2002 22:30:46 -0500
Date: Wed, 25 Dec 2002 19:39:02 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: J Sloan <joe@tmsusa.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CPU failures ... or something else ?
In-Reply-To: <3E0A7944.2030505@tmsusa.com>
Message-ID: <20021225193855.W6873-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thanks for that advice - much appreciated.



On Wed, 25 Dec 2002, J Sloan wrote:

> FWIW, I had 3 identical 2450s similar to
> yours, all with RH linux 7.2 installed -
> 2 of them were rock solid, the other had
> random crashes, nothing in the logs, no
> pattern to the crashes that I could see.
>
> Dell had me upgrade/reflash the BIOS
> and the perc raid controller, and the box
> has been rock solid ever since...
>
> Just my $.02 on the matter -
>
> Joe
>
> Josh Brooks wrote:
>
> >Oh and by the way, this is a dell poweredge 2450, dual 866 p3 cpus, 2gigs
> >ram, and using a PERC 3/D.  I have a 2.4.1 system running on _identical_
> >hardware with no problems, and this system that is MCE'ing is a 2.4.16.
> >
> >So ... not sure if that raises any red flags as far as false/spurious MCEs
> >are concerned, but either way comments are appreciated.
> >
> >I will try the nomce option just in case, but I suspect I have bad
> >hardware.  Again, any comments / war stories appreciated.
> >
> >thanks!
> >
> >On Wed, 25 Dec 2002, Bubba wrote:
> >
> >
> >
> >>try turning off the Machine Check Exception in the kernel as it is just buggy
> >>on some machines, not necessarily a bug in the kernel, or without
> >>recompiling, use the kernel param "nomce"
> >>
> >>On Wednesday 25 December 2002 19:53, Josh Brooks wrote:
> >>
> >>
> >>>Hello,
> >>>
> >>>I have a dual p3 866 running 2.4 kernel that is crashing once every few
> >>>days leaving this on the console:
> >>>
> >>>
> >>>Message from syslogd@localhost at Tue Dec 24 11:30:31 2002 ...
> >>>localhost kernel: CPU 1: Machine Check Exception: 0000000000000004
> >>>
> >>>Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> >>>localhost kernel: Bank 4: b200000000040151
> >>>
> >>>Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> >>>localhost kernel: Kernel panic: CPU context corrupt
> >>>
> >>>
> >>>
> >>>Word on the street is that this indicates hardware failure of some kind
> >>>(cpu, bus, or memory).  My main question is, is that very surely the
> >>>culprit, or is it also possible that all of the hardware is perfect and
> >>>that a bug in the kernel code or some outside influence (remote exploit)
> >>>is causing this crash ?
> >>>
> >>>Basically, I am ordering all new hardware to swap out, and I just want to
> >>>know if there is some remote possibility that my hardware is actually just
> >>>fine and this is some kind of software error ?
> >>>
> >>>ALSO, I have not been physically at the console when this has happened,
> >>>and have not tried this yet, but whatever that thing is where you press
> >>>ctrl-alt-printscreen and get to enter those post-crash commands - do you
> >>>think that would work in this situation, or does the above error hard lock
> >>>the system so you can't do those emergency measures ?
> >>>
> >>>thanks!
> >>>
> >>>
> >>>-
> >>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>>the body of a message to majordomo@vger.kernel.org
> >>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>Please read the FAQ at  http://www.tux.org/lkml/
> >>>
> >>>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>
> >>
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

