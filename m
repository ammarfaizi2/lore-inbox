Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVCKWnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVCKWnl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVCKWnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:43:40 -0500
Received: from fire.osdl.org ([65.172.181.4]:17353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261803AbVCKWfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:35:18 -0500
Date: Fri, 11 Mar 2005 14:34:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: george@mvista.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
Message-Id: <20050311143459.54c74dd0.akpm@osdl.org>
In-Reply-To: <1110579830.19661.10.camel@mindpipe>
References: <1109869828.2908.18.camel@mindpipe>
	<20050303164520.0c0900df.akpm@osdl.org>
	<1109899148.3630.5.camel@mindpipe>
	<42283857.9050007@mvista.com>
	<1109968985.6710.16.camel@mindpipe>
	<4228CBFB.3000602@mvista.com>
	<1110313644.4600.13.camel@mindpipe>
	<422E33F0.6020403@mvista.com>
	<4230087E.3080307@mvista.com>
	<1110579830.19661.10.camel@mindpipe>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Thu, 2005-03-10 at 00:42 -0800, George Anzinger wrote:
> > This patch changes the update of the cmos clock to be timer driven
> > rather than poll driven by the timer interrupt function.  If the clock
> > is not being synced to an outside source the timer is removed and thus
> > system overhead is nill in that case.  The update frequency is still ~11
> > minutes and missing the update window still causes a retry in 60
> > seconds.
> 
> No replies yet.  Are there any objections to this patch?

Nope.  I think it's neat.  I queued it up.

