Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbULJTJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbULJTJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 14:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbULJTJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 14:09:55 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:36753 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261801AbULJTJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 14:09:53 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>, Shane Shrybman <shrybman@aei.ca>,
       Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       thewade <pdman@aproximation.org>
In-Reply-To: <20041210105352.GA4749@elte.hu>
References: <OF8ABCEBAC.0259E37D-ON86256F65.00727E98@raytheon.com>
	 <20041209225555.GA31588@elte.hu>  <20041210105352.GA4749@elte.hu>
Content-Type: text/plain
Date: Fri, 10 Dec 2004 14:09:49 -0500
Message-Id: <1102705789.29919.14.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 11:53 +0100, Ingo Molnar wrote:
> The -32-15 kernel can be downloaded from the
> usual place:
> 
>  http://redhat.com/~mingo/realtime-preempt/

Any chance this will work on x86_64 anytime soon?  Not necessarily
PREEMPT_RT, it would be nice if PREEMPT_DESKTOP worked.  You mentioned a
few weeks ago it needs the timer interrupt threading changes.

  CC      arch/x86_64/kernel/asm-offsets.s
In file included from include/asm/timex.h:12,
                 from include/linux/timex.h:61,
                 from include/linux/sched.h:11,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/asm/vsyscall.h:55: error: conflicting types for \'xtime_lock\'
include/linux/time.h:83: error: previous declaration of \'xtime_lock\'
was here
include/asm/vsyscall.h:55: error: conflicting types for \'xtime_lock\'
include/linux/time.h:83: error: previous declaration of \'xtime_lock\'
was here
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [arch/x86_64/kernel/asm-offsets.s] Error 2

Lee 

