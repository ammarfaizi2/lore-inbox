Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVLVXCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVLVXCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbVLVXCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:02:43 -0500
Received: from mail3.uklinux.net ([80.84.72.33]:5318 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1030342AbVLVXCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:02:43 -0500
Date: Thu, 22 Dec 2005 23:11:53 +0000
From: John Rigg <lk@sound-man.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rc5-rt4 fails to compile - question
Message-ID: <20051222231153.GA4316@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday Dec 21 2005 John Rigg wrote:
> 2.6.14-rc5-rt4
> failed to compile
> on x86_64 SMP
>
> kernel/hrtimer.c: In function 'hrtimer_cancel':
> kernel/hrtimer.c:673: error: 'HRTIMER_SOFTIRQ' undeclared (first use in this function)
> kernel/hrtimer.c:673: error: (Each undeclared identifier is reported only once
> kernel/hrtimer.c:673: error: for each function it appears in.)
> make[1]: *** [kernel/hrtimer.o] Error 1
> make: *** [kernel] Error 2

The obvious way to get it to compile would be to use CONFIG_HIGH_RES_TIMERS=y .
Stupid question: how do I enable this on x86_64 SMP?
I can't find it in menuconfig and if I edit .config manually my edits just
get deleted (obviously I'm doing something wrong). I've tried grepping the
source and googling, but haven't been able to find the answer.

John
