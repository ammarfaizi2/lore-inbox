Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbUKAXbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbUKAXbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S382011AbUKAXba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:31:30 -0500
Received: from pop.gmx.net ([213.165.64.20]:3219 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S379091AbUKAWwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:52:12 -0500
X-Authenticated: #4399952
Date: Mon, 1 Nov 2004 23:51:25 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Bill Huey (hui) <bhuey@lnxw.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041101235125.2ae638a4@mango.fruits.de>
In-Reply-To: <20041101224047.GA19186@nietzsche.lynx.com>
References: <20041031134016.GA24645@elte.hu>
	<20041031162059.1a3dd9eb@mango.fruits.de>
	<20041031165913.2d0ad21e@mango.fruits.de>
	<20041031200621.212ee044@mango.fruits.de>
	<20041101134235.GA18009@elte.hu>
	<20041101135358.GA19718@elte.hu>
	<20041101140630.GA20448@elte.hu>
	<1099324040.3337.32.camel@thomas>
	<20041101184615.GB32009@elte.hu>
	<20041101233037.314337c8@mango.fruits.de>
	<20041101224047.GA19186@nietzsche.lynx.com>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004 14:40:47 -0800
Bill Huey (hui) <bhuey@lnxw.com> wrote:

> Unlikely, it's got to lock the entire kernel to make sure that things aren't
> changing under it. Getting measurements is useful at this stage, but don't expect
> it to be a finished product any time soon and please keep that in mind. Stability
> should be, if it's not already, the single most important things in this project
> at this phase. Getting numbers now for a specific single application is going to
> be of limit use until the system is stable enough for general characterization.
> 
> Keep doing it, but keep in mind that anything you're going to get at this time
> is going to be very coarse. Don't put too much weight on it.
> 
> That's my take.

ack. understood. i was just asking since i don't have a second machine and
thus am not really able to help with the deadlock debugging. so i figured i
could at least do some timing. btw: even with deadlock detection, the
results for 0.6.5 looked pretty good [in 10 minutes uptime ca.3-4% max
jitter [30something usecs].  until the deadlock that is [i head three finds
plus kernel compile at nice -10 running]..

flo
