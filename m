Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbULOB5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbULOB5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULOByp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:54:45 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:51870 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261848AbULOByD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:54:03 -0500
Message-Id: <200412150153.iBF1rpvj024463@localhost.localdomain>
To: linux-os@analogic.com
cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       George Anzinger <george@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0 
In-reply-to: Your message of "Tue, 14 Dec 2004 18:18:59 EST."
             <Pine.LNX.4.61.0412141805240.20391@chaos.analogic.com> 
Date: Tue, 14 Dec 2004 20:53:51 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.151.88.162] at Tue, 14 Dec 2004 19:53:55 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>When I use Cakewalk Home-Studio to record Music from my MIDI piano,
>I notice that the clock-resolution shown is several orders of
>magnitude better than anything a PC can generate! I haven't got

incoming timing is a solved problem. the problem is scheduling
outgoing data, which requires an interrupt source of some kind.

>a clue where this information comes from. It is in seconds, starting

they almost certainly use either the sample clock of the audio
interface interpolated/estimated using a DLL (Delay Locked Loop).

>I'm pretty sure that if Cakewalk decided to port Home Studio
>to Linux, they would be able to do it with no technical hurdles.
>Its just that, for Music, most use Apple and cheapskates like
>me use PCs running M$.

Real cheapskates would use Linux with Rosegarden, Ardour et al :)

--p
