Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270628AbUJUAqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270628AbUJUAqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270620AbUJUAnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:43:09 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:8068 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S270490AbUJUAeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 20:34:17 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <20041020094508.GA29080@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <20041020094508.GA29080@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1098318763.16441.48.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Oct 2004 17:32:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 02:45, Ingo Molnar wrote:
> i have released the -U8 Real-Time Preemption patch:
> 
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
> 
> this too is a fixes-only release.

A bit late, but a short report. I managed to boot into U8.1 (Athlon64 up
machine). But only if I turn off kudzu (the hardware discovery program
in FC2). If I leave it on, I get tons of kernel error or warning
messages on the console, they scroll too fast for me to read, once that
starts the machine is pretty much stuck - the messages keep scrolling
but that's about it. I have not managed to capture the output to see
what they say...

If I boot without kudzu I can use sound, but I have not done yet any
latency testing. 

-- Fernando


