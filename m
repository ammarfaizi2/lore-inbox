Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVBAAob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVBAAob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbVBAAl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:41:59 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:28934 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261499AbVBAAk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:40:27 -0500
Date: Mon, 31 Jan 2005 16:39:22 -0800
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050201003922.GA26460@nietzsche.lynx.com>
References: <20050128084049.GA5004@elte.hu> <41FEB136.5070706@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FEB136.5070706@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 05:29:10PM -0500, Bill Davidsen wrote:
> The problem hasn't changed in a few decades, neither has the urge of 
> developers to make their app look good at the expense of the rest of the 
> system. Been there and done that myself.
> 
> "Back when" we had no good tools except to raise priority and drop 
> timeslice if a process blocked for i/o and vice-versa if it used the 
> whole timeslice. The amzing thing is that it worked reasonably well as 
> long as no one was there who knew how to cook the books the scheduler 
> used. And the user could hold off interrupts for up to 16ms, just to 
> make it worse.

A lot of this scheduling policy work is going to have to be redone as
badly written apps start getting their crap together and as this patch
is more and more pervasive in the general Linux community. What's
happening now is only the beginning of things to come and it'll require
a solid sample application with even more hooks into the kernel before
we'll see the real benefits of this patch. SCHED_FIFO will have to do
until more development happens with QoS style policies.
 
bill

