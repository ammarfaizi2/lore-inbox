Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUB0JmW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 04:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbUB0JmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 04:42:22 -0500
Received: from [203.197.30.2] ([203.197.30.2]:36570 "EHLO kaveri.barc.ernet.in")
	by vger.kernel.org with ESMTP id S261753AbUB0Jls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 04:41:48 -0500
Message-ID: <403F1204.32683547@magnum.barc.ernet.in>
Date: Fri, 27 Feb 2004 15:16:44 +0530
From: Sonika Sachdeva <sonikam@magnum.barc.ernet.in>
Organization: BARC
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux scheduler Implementation details
References: <403F0B66.A7920233@magnum.barc.ernet.in> <403F0CD7.5080305@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to give the loaded system metrics(loadavg, io details etc) as the input to
the simulator program so that it is able to calculate the priority for any new job
that will be submitted.

Then knowing the execution time of that job in a no-load system, I am able to
compute the latency encountered becoz of the load on the system.

How can I reuse the sched.c code to do this?

Thank you
Regards
Sonika



Nick Piggin wrote:

> Sonika Sachdeva wrote:
>
> >Hello List,
> >
> >I want to simulate the Linux Scheduler, ie Calculate the priorities, counters
> >and define to some extent how much time a given process will take to execute on
> >the system. Can anyone suggest some pointers?
> >
> >
>
> It is all in kernel/sched.c, so you can just make a simulator and
> plug that code in.
>
> This will perfectly model the scheduler behaviour given some input
> from your simulator, which is what you asked for. This has nothing
> to do with maximum realtime scheduling latency, of course.

