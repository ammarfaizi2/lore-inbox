Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSBXMZs>; Sun, 24 Feb 2002 07:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSBXMZi>; Sun, 24 Feb 2002 07:25:38 -0500
Received: from varenorn.icemark.net ([212.40.16.200]:424 "EHLO
	varenorn.internal.icemark.net") by vger.kernel.org with ESMTP
	id <S286825AbSBXMZV>; Sun, 24 Feb 2002 07:25:21 -0500
Date: Sun, 24 Feb 2002 13:22:40 +0100 (CET)
From: Benedikt Heinen <beh@icemark.net>
X-X-Sender: beh@berenium.icemark.ch
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Some problems on a ThinkPad A30P (again...)
In-Reply-To: <200202241201.NAA11762@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0202241314540.15470-100000@berenium.icemark.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -> When the system resumes from a suspend, the following message
> >    turns up in dmesg:
> >
> >	APIC error on CPU0: 00(40)
>
> This indicates that your A30P has a local-APIC capable P6-class
> cpu, and that you're not using the latest 2.4.18-pre or -rc kernel.
>
> The APIC error at resume from suspend is fixed in current 2.4.18-rc,
> so a simple kernel upgrade will silence that message.

Hmm... OK, I might upgrade to the 2.4.18-rc; unless - any vague clue,
when the "regular" 2.4.18 should be due? Since the message is not
part of a crash or anything, I'd also happily wait for another few
days... ;)



> Your machine survives APM suspend? That's encouraging since I've
> had a report that the T20 doesn't if the local APIC is enabled.

Yes, it does...  Consistently...



> > -> Hibernation doesn't work at all (this used to work on the TP600
> >    and on the TP A21P I had before)...

> What's the difference between suspend and hibernate?
> Does the machine survive if you pull the power cord or enter the
> BIOS setup screens?

I don't remeber, whether you could even enter the BIOS setup screen
from hibernation, so I can't answer that...

In general - hibernation causes the notebook to dump the entire
system memory contents and system status to a hibernation file
(which is a contiguous hidden file on the Windows partition). Once
the dump is done, the machine powers off completely - AC power cord
and batteries can be safely removed/replaced during the time. When
you switch the system back on, and the hibernation file contains
system data, the RAM and system data is read back, and the system
can resume, from where it is  (obviously just all active the
network connections will be gone...  On the TP 600E, TP A21P this
worked fine).
The lack of hibernation is not a major problem for me though, as
going to suspend and staying in suspend for 4-8 hours eats less
battery than dumping 1 GB of RAM to disk and rereading it... Also,
suspends for up to about 8 hours conserve battery even compared to
rebooting; so most of the time I just suspend the machine for
transport... I just hibernate or turn off the machine if it's going
to be off for a longer period of time, or if I have to board a
plane with it... ;)



      Benedikt

  BEAUTY, n.  The power by which a woman charms a lover and terrifies a
    husband.
			(Ambrose Bierce, The Devil's Dictionary)

