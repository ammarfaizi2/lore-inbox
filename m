Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUJRTpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUJRTpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267645AbUJRThQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:37:16 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:42001 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267595AbUJRTdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:33:17 -0400
Date: Mon, 18 Oct 2004 12:32:51 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018193251.GA15313@nietzsche.lynx.com>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018145008.GA25707@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 04:50:08PM +0200, Ingo Molnar wrote:
> i have released the -U5 Real-Time Preemption patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5

  CC      arch/i386/kernel/traps.o
arch/i386/kernel/traps.c: In function `do_debug':
arch/i386/kernel/traps.c:786: error: `sysenter_past_esp' undeclared (first use in this function)
arch/i386/kernel/traps.c:786: error: (Each undeclared identifier is reported only once
arch/i386/kernel/traps.c:786: error: for each function it appears in.)
make[1]: *** [arch/i386/kernel/traps.o] Error 1
make: *** [arch/i386/kernel] Error 2

bill

