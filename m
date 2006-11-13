Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754365AbWKMJpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbWKMJpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754368AbWKMJpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:45:25 -0500
Received: from mx03.stofanet.dk ([212.10.10.13]:41403 "EHLO mx03.stofanet.dk")
	by vger.kernel.org with ESMTP id S1754365AbWKMJpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:45:24 -0500
Date: Mon, 13 Nov 2006 10:43:48 +0100 (CET)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Ingo Molnar <mingo@elte.hu>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 1/5] Fix timeout bug in rtmutex in 2.6.18-rt
In-Reply-To: <20061110144916.GA19152@elte.hu>
Message-ID: <Pine.LNX.4.64.0611131042510.13569@frodo.shire>
References: <20061001112829.630288000@frodo> <Pine.LNX.4.64.0610011336400.29459@frodo.shire>
 <20061110144916.GA19152@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Nov 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <nielsen.esben@googlemail.com> wrote:
>
>>  include/linux/init_task.h |    1
>>  include/linux/sched.h     |   62
>>  kernel/sched.c            |   29 +++++++++++++++++----
>
> what kernel tree is this supposed to be against? Neither vanilla nor
> -rt7 2.6.18 works:

Sorry, I missed the exact number. I believe it was 2.6.18-rt5 or 
2.6.18-rt6. I know it wasn't -rt7 because Thomas changed the locking..

Esben

>
> Hunk #1 FAILED at 91.
> 1 out of 1 hunk FAILED -- rejects in file include/linux/init_task.h
> patching file include/linux/sched.h
> Hunk #1 FAILED at 928.
> Hunk #2 FAILED at 1330.
> 2 out of 2 hunks FAILED -- rejects in file include/linux/sched.h
> patching file kernel/sched.c
> Hunk #1 succeeded at 157 with fuzz 2 (offset -7 lines).
> Hunk #2 FAILED at 700.
> Hunk #3 FAILED at 774.
> Hunk #4 FAILED at 792.
> Hunk #5 FAILED at 1475.
> 4 out of 5 hunks FAILED -- rejects in file kernel/sched.c
>
> 	Ingo
>
