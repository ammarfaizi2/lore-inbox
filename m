Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbULOCtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbULOCtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 21:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbULOCtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 21:49:51 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:41907 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261823AbULOCtr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 21:49:47 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org, linux-os@analogic.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
Date: Tue, 14 Dec 2004 21:49:45 -0500
User-Agent: KMail/1.7
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@raytheon.com>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       George Anzinger <george@mvista.com>,
       Paul Davis <paul@linuxaudiosystems.com>
References: <20041124101626.GA31788@elte.hu> <1103064432.14699.69.camel@krustophenia.net> <Pine.LNX.4.61.0412141805240.20391@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0412141805240.20391@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412142149.46092.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.42.94] at Tue, 14 Dec 2004 20:49:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 December 2004 18:18, linux-os wrote:
>On Tue, 14 Dec 2004, Lee Revell wrote:

>>> <clueless question> roughly what latency/accuracy requirements
>> Lee
>
>When I use Cakewalk Home-Studio to record Music from my MIDI piano,
>I notice that the clock-resolution shown is several orders of
>magnitude better than anything a PC can generate! I haven't got
>a clue where this information comes from. It is in seconds, starting
>at 1 (not zero, don't know why) and has resolution of microseconds
>with no missing codes. This is on a M$ PC.
>
>This generates a highly-accurate "time ruler". One can back-up
>through this time and resolve samples that appear synchronous
>but can be displaced in time with apparent resolution much
>better than the 38,400 baud-rate of MIDI. I don't know how
>they do it, but this is the MIDI "sample-clock". It has to
>be virtual because there isn't any hardware on a PC that can
>duplicate it.

Midi's baud rate isn't 38,400, its 31,250.  Check your
references.  It should be in any keyboards manual.

>It is likely that they use a software PLL with some periodic
>updates from a timer-tick, but it sure looks impressive to
>see "real-time" with such resolution on a PC.

Well, it is pretty slow for a non multiuser os equipt with todays
hardware.

>I'm pretty sure that if Cakewalk decided to port Home Studio
>to Linux, they would be able to do it with no technical hurdles.
>Its just that, for Music, most use Apple and cheapskates like
>me use PCs running M$.
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by John Ashcroft.

I don't want to bring politics into this group it has no place
here.  None, nada.   But, since you mentioned it, screw Ashcroft
and the camel that ride in on him.  He has done more to bring true
democracy to its knees in 4 years than all others before him in
our 230 years.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

