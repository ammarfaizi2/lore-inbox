Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWFHTDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWFHTDB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbWFHTDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:03:01 -0400
Received: from www.osadl.org ([213.239.205.134]:1255 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964935AbWFHTDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 15:03:00 -0400
Subject: Re: 2.6.17-rc6-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Kevin Hilman <khilman@deeprooted.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>, Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149791229.6348.19.camel@vence.internal.net>
References: <20060607211455.GA6132@elte.hu>
	 <1149791229.6348.19.camel@vence.internal.net>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 21:03:27 +0200
Message-Id: <1149793407.5257.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 11:27 -0700, Kevin Hilman wrote:
> On Wed, 2006-06-07 at 23:14 +0200, Ingo Molnar wrote:
> > i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from 
> > the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> 
> Here's a couple of fixes/updates:
> 
> 1) Fix for arm-generic-timeofday.patch which doesn't compile against
> 2.6.17-rc6
> 
> 2) Add clocksource for arch/arm/mach-ixp4xx

Thanks, applied

> Also, I notice both asm-arm/timeofday.h and asm-ia64/timeofday.h simply
> include asm-generic/timeofday.h which doesn't exist.  Should the former
> be removed also?

Yes, thats a leftover from the older timeofday code which was in
2.6.16-rtxx. Removed.

	tglx


