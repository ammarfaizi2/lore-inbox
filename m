Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWBKPeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWBKPeh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 10:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWBKPeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 10:34:37 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:26018 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932322AbWBKPeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 10:34:37 -0500
Date: Sat, 11 Feb 2006 10:34:20 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: john stultz <johnstul@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG -rt] -rt16 hang w/ realtime thread test
In-Reply-To: <1139626674.28536.30.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0602111033400.13041@gandalf.stny.rr.com>
References: <1139626674.28536.30.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Feb 2006, john stultz wrote:

> Hey Ingo,
> 	I've been hunting a report that lower priority realtime threads are not
> preempting higher priority realtime threads. However, in generating test
> cases, I found I was locking the system quite frequently.
>
> The attached test runs to completion on 2.6.15, but with 2.6.15-rt16, it
> hangs the box. It could very well be a test issue, but I'm not sure I
> see where the problem is.
>

Hi John,

Have you turned on nmi_watchdog and softlockup detect?  Just so we can see
where it is hung.

Thanks,

-- Steve
