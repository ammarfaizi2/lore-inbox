Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWENDqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWENDqm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 23:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWENDqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 23:46:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:5762 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932203AbWENDql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 23:46:41 -0400
X-Authenticated: #14349625
Subject: Re: rt20 scheduling latency testcase and failure data
From: Mike Galbraith <efault@gmx.de>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <200605131601.31880.dvhltc@us.ibm.com>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <200605131106.16864.dvhltc@us.ibm.com> <1147544472.6535.294.camel@mindpipe>
	 <200605131601.31880.dvhltc@us.ibm.com>
Content-Type: text/plain
Date: Sun, 14 May 2006 05:46:53 +0200
Message-Id: <1147578414.7738.11.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 16:01 -0700, Darren Hart wrote:
> On Saturday 13 May 2006 11:21, Lee Revell wrote:
> > On Sat, 2006-05-13 at 11:06 -0700, Darren Hart wrote:
> > >      1 [softirq-timer/0]
> >
> > What happens if you set the softirq-timer threads to 99?
> >
> 
> After setting all 4 softirq-timer threads to prio 99 I seemed to get only 2 
> failures in 100 runs.

If you disable printf + fflush in iterations loop, problem goes away?

	-Mike

