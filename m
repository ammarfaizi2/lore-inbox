Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbRERQBn>; Fri, 18 May 2001 12:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262367AbRERQBg>; Fri, 18 May 2001 12:01:36 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:48879 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S262364AbRERQAZ>; Fri, 18 May 2001 12:00:25 -0400
Message-Id: <l03130303b72af49d4f0a@[192.168.239.105]>
In-Reply-To: <20010518112625.A14309@thyrsus.com>
In-Reply-To: <3B053B9B.23286E6C@redhat.com>; from arjanv@redhat.com on Fri,
 May 18, 2001 at 04:11:23PM +0100 <20010518034307.A10784@thyrsus.com>
 <E150fV9-0006q1-00@the-village.bc.nu> <20010518105353.A13684@thyrsus.com>
 <3B053B9B.23286E6C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 18 May 2001 16:59:47 +0100
To: esr@thyrsus.com, Arjan van de Ven <arjanv@redhat.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: CML2 design philosophy heads-up
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Aunt Tillie doesn't even know what a kernel is, nor does she want
>> to. I think it's fair to assume that people who configure and
>> compile their own kernel (as opposed to using the distribution
>> supplied ones) know what they are doing.
>
>I'd like to break these assumptions.  Or at the very least see how far
>they can be bent.  I know this sounds crazy to a lot of hackers, but
>I think there's a certain amount of unhelpful elitism and self-puffery
>in the "kernels are hard to configure and they *should* be hard to
>configure* attitude.  Let's give Aunt Tillie a chance to surprise us.

Not everyone falls into the "expert user" and "Aunt Tillie" categories.
It's a *very* big grey area.  If some semi-computer-literate user (ie. some
friends of mine!) wants to upgrade their kernel so they have access to
newer hardware (such as a cheap USB webcam), it should be made as simple as
possible for them.  CML1 doesn't handle that very well, I'd like to see
it's replacement do better.

So, the first questions should be along the lines of "Do you have
(approximately) these kinds of standard configuration?" starting with "x86
PC", "Apple PowerMac" and other sensible defaults - followed by "none of
the above".  Then later on, things like "Do you have SCSI?" followed by
"What type of SCSI card(s)".  And under IDE configuration, we have "Do you
want IDE-SCSI emulation (useful for CD-writers and such)?" which turns on
SCSI without any of the card drivers.

The above strategy, if extended properly, would allow novice users to get
*something* which worked, more easily.  More advanced users could then
fiddle with settings they knew about, and experiment.  Those who *really*
know what they're up to can create a wholly customised setup by choosing
"none of the above", right at the beginning.

As for the language CML2 is written in, surely C would work just as well as
Python if the config-ruleset file is in a known format.  GCC is required
for the kernel to build, I don't see why anything else should be required
simply to configure it.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
-----END GEEK CODE BLOCK-----


