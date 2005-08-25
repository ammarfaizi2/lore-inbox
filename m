Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVHYPgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVHYPgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbVHYPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:36:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:33787 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932168AbVHYPgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:36:54 -0400
Subject: Re: 2.6.13-rc7-rt1
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20050825062651.GA26781@elte.hu>
References: <20050825062651.GA26781@elte.hu>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 08:36:44 -0700
Message-Id: <1124984208.25139.0.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does anyone have x86_64 working in PREEMPT_RT ?

Daniel


On Thu, 2005-08-25 at 08:26 +0200, Ingo Molnar wrote:
> i have released the 2.6.13-rc7-rt1 tree, which can be downloaded from 
> the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes-only release. Changes since 2.6.13-rc6-rt10:
> 
>  - init_hrtimers() compilation fix (K.R. Foley)
> 
>  - first phase p->pi_lock SMP speedup (Steven Rostedt)
> 
>  - HRT/signals exit fixes (Thomas Gleixner)
> 
>  - change single-signal delivery (used by e.g. HRT) to RCU
>    (Thomas Gleixner)
> 
>  - fix larger-than-5-sec sleeps (Thomas Gleixner)
> 
>  - ALL_TASKS_PI compilation fixes (Daniel Walker)
> 
>  - HRT compilation warning fix (Daniel Walker)
> 
>  - PPC fixes (Thomas Gleixner)
> 
>  - merge to 2.6.13-rc7
> 
>  - disable old HIGH_RES_TIMERS code in ipmi
> 
>  - sx8.c semaphore -> compat_semaphore
> 
>  - route.c kmalloc-size build fix
> 
> to build a 2.6.13-rc7-rt1 tree, the following patches should be applied:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
>    http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc7.bz2
>    http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rc7-rt1
> 
> 	Ingo

