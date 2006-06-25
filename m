Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWFYOYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWFYOYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 10:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWFYOYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 10:24:22 -0400
Received: from mail.timesys.com ([65.117.135.102]:15309 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP
	id S1751428AbWFYOYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 10:24:21 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
	dynamic HZ
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <Pine.LNX.4.58.0606250904530.5324@gandalf.stny.rr.com>
References: <1150643426.27073.17.camel@localhost.localdomain>
	 <449580CA.2060704@gmail.com> <20060618182820.GA32765@elte.hu>
	 <4496D24F.80003@gmail.com>
	 <1150746705.29299.57.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0606250904530.5324@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 16:26:02 +0200
Message-Id: <1151245562.25491.365.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 09:06 -0400, Steven Rostedt wrote:
> Hi Thomas,
> 
> I finally was able to try -V5. And hit the following:
> 
> WARNING: "hrtimer_stop_sched_tick" [drivers/acpi/processor.ko] undefined!
> WARNING: "hrtimer_restart_sched_tick" [drivers/acpi/processor.ko] undefined!

Thanks, applied.

	tglx


