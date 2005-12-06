Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbVLFVyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbVLFVyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVLFVyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:54:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:18375 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030263AbVLFVyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:54:18 -0500
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B13)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       nikita@clusterfs.com, Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Cal Peake <cp@absolutedigital.net>
In-Reply-To: <20051206041348.9843.85752.sendpatchset@cog.beaverton.ibm.com>
References: <20051206041348.9843.85752.sendpatchset@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 13:54:13 -0800
Message-Id: <1133906053.10613.3.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 21:13 -0700, john stultz wrote:
> 	The following patchset applies against 2.6.15-rc5 + the hrtimer patch-
> set and provides a generic timekeeping subsystem that is independent of the 
> timer interrupt. This allows for robust and correct behavior in cases 
> of late or lost ticks, avoids interpolation errors, reduces duplication 
> in arch specific code, and allows or assists future changes such as 
> high-res timers, dynamic ticks, or realtime preemption. Additionally, 
> it provides finer nanosecond resolution values to the clock_gettime 
> functions.

I've gotten a number of requests for a website pointer for this code,
and Dave Hanson has generously created an account for me on his system.

Thus, the B13 release can be found at:
	http://sr71.net/~jstultz/tod/

thanks
-john

