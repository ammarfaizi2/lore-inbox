Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVK0Mao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVK0Mao (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 07:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVK0Mao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 07:30:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44174 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751029AbVK0Mao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 07:30:44 -0500
Date: Sun, 27 Nov 2005 13:30:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
Message-ID: <20051127123052.GA22807@elte.hu>
References: <1132987928.4896.1.camel@mindpipe> <20051126122332.GA3712@elte.hu> <1133031912.5904.12.camel@mindpipe> <1133034406.32542.308.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133034406.32542.308.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sat, 2005-11-26 at 14:05 -0500, Lee Revell wrote:
> 
> > -rt19 seems to work except that asm/io_apic.h fails to include 
> > asm/apicdef.h so MAX_IO_APICS is undefined.
> 
> The patch below fixes the Makefile x86_64 clutter and the io_apic 
> compile problem

thanks, applied.

	Ingo
