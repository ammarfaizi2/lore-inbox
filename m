Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWENHi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWENHi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 03:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWENHi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 03:38:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:11186 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751369AbWENHi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 03:38:26 -0400
X-Authenticated: #14349625
Subject: Re: rt20 scheduling latency testcase and failure data
From: Mike Galbraith <efault@gmx.de>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Lee Revell <rlrevell@joe-job.com>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <200605140004.30307.dvhltc@us.ibm.com>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <1147578414.7738.11.camel@homer> <1147585718.9372.15.camel@homer>
	 <200605140004.30307.dvhltc@us.ibm.com>
Content-Type: text/plain
Date: Sun, 14 May 2006 09:38:42 +0200
Message-Id: <1147592323.7564.23.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-14 at 00:04 -0700, Darren Hart wrote:
> > > > On Saturday 13 May 2006 11:21, Lee Revell wrote:
> > > If you disable printf + fflush in iterations loop, problem goes away?
> 
> Unfortunately not, after disabling the printf and fflush, my very first run 
> resulted in:

Drat.

> What is it about this dump that made you suspect the printf?  Or was it just 
> that printing the trace seemed to trigger a failure - so it seemed reasonable 
> that the process may have been blocked on writing to the console?

Yeah, realtime task in D state.

	-Mike

