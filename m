Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbUL0VH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUL0VH6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 16:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUL0VH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 16:07:58 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:48654 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261978AbUL0VHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 16:07:51 -0500
Date: Mon, 27 Dec 2004 13:06:14 -0800
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15)
Message-ID: <20041227210614.GA11052@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10412271655270.18818-100000@da410.ifa.au.dk> <1104165560.20042.108.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104165560.20042.108.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2004 at 11:39:20AM -0500, Steven Rostedt wrote:
> Actually, I've had some success with NVIDIA on all my kernels (except of

Doesn't the NVidia driver use their own version of DRM/DRI ?
If so, then did you tell it to use the Linux kernel versions of that
driver ?

> course the realtime ones). Unfortunately, there are the little crashes
> here and there, but those usually happen with screen savers so I don't

I was just having a discussion about this last night with a friend
of mine and I'm going to pose this question to you and others.

Is a real-time enabled kernel still relevant for high performance
video even with GPUs being as fast as they are these days ?

The context that I'm working with is that I was told (been out of
gaming for a long time now) that GPus are so fast these days that
shortage of frame rate isn't a problem any more. An RTOS would be
able to deliver a data/instructions to the GPU under a much tighter
time period and could delivery better, more consistent frame rates.

Does this assertion still apply or not ? why ? (for either answer)

bill

