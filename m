Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUB0Kyi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 05:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUB0Kyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 05:54:37 -0500
Received: from [203.197.30.2] ([203.197.30.2]:47045 "EHLO kaveri.barc.ernet.in")
	by vger.kernel.org with ESMTP id S261793AbUB0KyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 05:54:18 -0500
Message-ID: <403F2306.C51C75E8@magnum.barc.ernet.in>
Date: Fri, 27 Feb 2004 16:29:18 +0530
From: Sonika Sachdeva <sonikam@magnum.barc.ernet.in>
Organization: BARC
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux scheduler Implementation details
References: <403F0B66.A7920233@magnum.barc.ernet.in> <403F0CD7.5080305@cyberone.com.au> <403F1204.32683547@magnum.barc.ernet.in> <403F16E2.2040706@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if you could give me some hints to do fair approximations (to calculate
execution time) for scheduling process?

Regards
Sonika

Nick Piggin wrote:

> Sonika Sachdeva wrote:
>
> >Hi,
> >
> >I want to give the loaded system metrics(loadavg, io details etc) as the input to
> >the simulator program so that it is able to calculate the priority for any new job
> >that will be submitted.
> >
> >Then knowing the execution time of that job in a no-load system, I am able to
> >compute the latency encountered becoz of the load on the system.
> >
> >How can I reuse the sched.c code to do this?
> >
> >
>
> You can use it to tell your simulator how the Linux kernel will
> schedule tasks. I'm not sure exactly what you want, execution time?
> latency?

