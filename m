Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268751AbUJSM5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbUJSM5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 08:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUJSM5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 08:57:09 -0400
Received: from www2.muking.org ([216.231.42.228]:26459 "HELO www2.muking.org")
	by vger.kernel.org with SMTP id S268751AbUJSM5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 08:57:06 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	<20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	<20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
From: Kevin Hilman <kevin@hilman.org>
Organization: None to speak of.
Date: 19 Oct 2004 05:57:05 -0700
In-Reply-To: <20041018145008.GA25707@elte.hu>
Message-ID: <83wtxmuaqm.fsf@www2.muking.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> i have released the -U5 Real-Time Preemption patch:

[...] 

> the generic semaphore implementation (which uses rwsems) makes it
> possible to use the deadlock detection mechanism for all the mutex types
> we currently have: semaphores, rw-semaphores, spinlock-mutexes and
> rwlock-mutexes. Another benefit is that PREEMPT_REALTIME becomes much
> more portable this way. (although it's still x86-only at the moment.)

Speaking of portability, is anyone yet working on ports to other
platforms?  I'm particularily interested in ARM.

If anyone has started on ARM, I'd be glad to help out.

Kevin
http://hilman.org/kevin/ 
