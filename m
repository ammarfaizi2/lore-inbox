Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVADVdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVADVdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVADVIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:08:51 -0500
Received: from gw.indranet.co.nz ([203.167.203.10]:32016 "EHLO
	enso.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id S262008AbVADVGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:06:30 -0500
In-Reply-To: <20041227210614.GA11052@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10412271655270.18818-100000@da410.ifa.au.dk> <1104165560.20042.108.camel@localhost.localdomain> <20041227210614.GA11052@nietzsche.lynx.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ED17612C-5E64-11D9-9D1C-000D93C603C0@indranet.co.nz>
Content-Transfer-Encoding: 7bit
Cc: Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>,
       Gunther Persoons <gunther_persoons@spymac.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Shane Shrybman <shrybman@aei.ca>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, emann@mrv.com,
       Adam Heath <doogie@debian.org>, Steven Rostedt <rostedt@goodmis.org>,
       "K.R. Foley" <kr@cybsft.com>, Lee Revell <rlrevell@joe-job.com>,
       Esben Nielsen <simlo@phys.au.dk>, Amit Shah <amit.shah@codito.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Florian Schmidt <mista.tapas@gmx.net>
From: Andrew McGregor <andrew@indranet.co.nz>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15)
Date: Wed, 5 Jan 2005 04:25:55 +1300
To: Bill Huey (hui) <bhuey@lnxw.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/12/2004, at 10:06 AM, Bill Huey (hui) wrote:

> On Mon, Dec 27, 2004 at 11:39:20AM -0500, Steven Rostedt wrote:
>> Actually, I've had some success with NVIDIA on all my kernels (except 
>> of
>
> Doesn't the NVidia driver use their own version of DRM/DRI ?
> If so, then did you tell it to use the Linux kernel versions of that
> driver ?
>
>> course the realtime ones). Unfortunately, there are the little crashes
>> here and there, but those usually happen with screen savers so I don't
>
> I was just having a discussion about this last night with a friend
> of mine and I'm going to pose this question to you and others.
>
> Is a real-time enabled kernel still relevant for high performance
> video even with GPUs being as fast as they are these days ?

It is if you want to do any audio at the same time, as you usually do.

Andrew

