Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUKWVsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUKWVsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUKWVsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:48:02 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:18382 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261378AbUKWVrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:47:22 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0,
	and 30-9
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@kihontech.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1101244924.32068.6.camel@localhost.localdomain>
References: <OF73D7316A.42DF9BE5-ON86256F54.0057B6DC@raytheon.com>
	 <Pine.LNX.4.58.0411222237130.2287@gradall.private.brainfood.com>
	 <20041123115201.GA26714@elte.hu>
	 <Pine.LNX.4.58.0411231206240.2146@gradall.private.brainfood.com>
	 <Pine.LNX.4.58.0411231316300.2242@gradall.private.brainfood.com>
	 <1101244924.32068.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 23 Nov 2004 16:47:18 -0500
Message-Id: <1101246438.1594.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-23 at 16:22 -0500, Steven Rostedt wrote:
> Just curious to why you scale the interrupts from 49 down to 25.  What
> would be wrong with keeping all of them at 49 (or whatever). Being a
> FIFO, no interrupt would preempt another. Why would you want the first
> IRQs to be registered have higher priority than (and thus will preempt)
> irqs registered later.

I raised this issue before.  I agree that all interrupts should get the
same RT prio by default.  Otherwise the default behavior is arbitrary.

Lee

