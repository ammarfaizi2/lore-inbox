Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268698AbUJUMQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268698AbUJUMQB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUJUMOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:14:23 -0400
Received: from mail.timesys.com ([65.117.135.102]:3717 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S268766AbUJUMAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:00:46 -0400
Message-ID: <4177A49E.3060901@timesys.com>
Date: Thu, 21 Oct 2004 07:59:26 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@suse.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <30690.195.245.190.93.1098349976.squirrel@195.245.190.93> <1098350190.26758.24.camel@thomas> <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <1098353505.26758.38.camel@thomas> <20041021104222.GA8747@elte.hu>
In-Reply-To: <20041021104222.GA8747@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2004 11:55:34.0984 (UTC) FILETIME=[DFA32480:01C4B764]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
>>Yeah, for a semaphore it is, but not for a mutex.
>>
>
>but mutexes dont exist in upstream Linux as a separate entity. (they
>exist in my tree but that's another ballgame.)
>
Mutexes layered on existing semaphores seems convenient
at the moment. However a more native mutex mechanism
which tracks ownership would provide a basis for PI as
well as further instrumentation. This may not be an
issue at the present but I don't think it is too far
off.

-john




-- 
john.cooper@timesys.com

