Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbUK2WLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUK2WLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUK2WLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:11:37 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:17547 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S261827AbUK2WLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:11:07 -0500
Message-ID: <41ACB846.40400@free.fr>
Date: Tue, 30 Nov 2004 19:13:26 +0100
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu>
In-Reply-To: <20041129111634.GB10123@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I'm getting this error with V0.7.31-13

CC kernel/wait.o
CC kernel/kfifo.o
CC kernel/sys_ni.o
CC kernel/rt.o
CC kernel/latency.o
kernel/latency.c: In function `check_critical_timing':
kernel/latency.c:730: too few arguments to function `___trace'
kernel/latency.c:730: warning: too few arguments passed to inline 
function, suppressing inlining
kernel/latency.c: In function `__start_critical_timing':
kernel/latency.c:810: incompatible type for argument 1 of `____trace'
kernel/latency.c:810: warning: passing arg 2 of `____trace' makes 
pointer from integer without a cast
kernel/latency.c:810: too few arguments to function `____trace'
kernel/latency.c: In function `trace_irqs_off':
kernel/latency.c:810: warning: too few arguments passed to inline 
function, suppressing inlining
kernel/latency.c: In function `add_preempt_count':
kernel/latency.c:810: warning: too few arguments passed to inline 
function, suppressing inlining
kernel/latency.c: At top level:
kernel/latency.c:810: warning: too few arguments passed to inline 
function, suppressing inlining
make[1]: *** [kernel/latency.o] Error 1
make: *** [kernel] Error 2
[root@tigre01 im]#

Regards
Remi


