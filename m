Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266144AbUGEPlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUGEPlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 11:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUGEPld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 11:41:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:25486 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266130AbUGEPlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 11:41:22 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20040705162139.00b1caa8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 05 Jul 2004 17:33:09 +0200
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: RE: Maximum frequency of re-scheduling (minimum time quantum)
  que stio n
In-Reply-To: <313680C9A886D511A06000204840E1CF08F42FD4@whq-msgusr-02.pit
 .comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:18 AM 7/5/2004 -0400, Povolotsky, Alexander wrote:

>Mike - the part of my original question was - what is the minimum "measure"
>(in time ticks or is fraction of the time tick ?) of that "(almost) any time
>? In another words, assuming what is the latency between the moment, when
>the higher priority process (or thread ) is becoming available  to run (and
>assuming that "schedule()" system call is not explicitly called at that time
>...)and the moment when the scheduler STARTS (I am not including context
>switch time into the question here) the process of preemtion (start of the
>context switch). Is this time  settable (at compile time ) ?

Ah, you want wakeup latency numbers.  Sorry, I don't have any.  I believe 
Andrew and Davide both wrote tools for measuring in the wild, a search of 
the archives should turn up something that will give you the numbers you're 
looking for.

If I'm understanding your question, no, there is no latency guarantee.


> >If you're looking for an interface into the scheduler that allows you to
> >twiddle slice length
>
>you mean at the run time (vs compile time), I assume ?

Yes.

         -Mike 

