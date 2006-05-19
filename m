Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWESGZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWESGZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 02:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWESGZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 02:25:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:9928 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932246AbWESGZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 02:25:15 -0400
X-Authenticated: #14349625
Subject: Re: rt20 scheduling latency testcase and failure data
From: Mike Galbraith <efault@gmx.de>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <1148017723.8515.6.camel@homer>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <20060518084722.GA3343@elte.hu> <1147942687.4996.28.camel@frecb000686>
	 <200605180238.33044.dvhltc@us.ibm.com>  <1148017723.8515.6.camel@homer>
Content-Type: text/plain
Date: Fri, 19 May 2006 07:58:42 +0200
Message-Id: <1148018322.8678.1.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-19 at 07:48 +0200, Mike Galbraith wrote:
> I just got a trace from rt23 that contains...
> 
> sched_la-8326  0.... 4977us : hrtimer_cancel (do_nanosleep)
> ...
> sched_la-8322  1.... 14358us : hrtimer_cancel (do_nanosleep)
> 
> ...if anyone is interested.

Ahem.  Never mind.  I was too glued to usecs to notice pid :)

