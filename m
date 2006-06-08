Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWFHTy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWFHTy6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWFHTy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:54:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:45966 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964954AbWFHTy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 15:54:57 -0400
Subject: Re: 2.6.17-rc6-rt1
From: john stultz <johnstul@us.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149756709.11429.5.camel@Homer.TheSimpsons.net>
References: <20060607211455.GA6132@elte.hu>
	 <1149756709.11429.5.camel@Homer.TheSimpsons.net>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 12:52:19 -0700
Message-Id: <1149796339.4266.114.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 10:51 +0200, Mike Galbraith wrote:
> On Wed, 2006-06-07 at 23:14 +0200, Ingo Molnar wrote:
> > i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from 
> > the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > the biggest change was the port to 2.6.17-rc6, and the moving to John's 
> > latest and greatest GTOD queue.
> 
> hangcheck-timer.c misses monotonic_clock().


This fix from Andrew's tree was missed:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/broken-out/hangcheck-remove-monotomic_clock-on-x86.patch

Ingo, please apply.

thanks
-john

