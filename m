Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319084AbSHSWiu>; Mon, 19 Aug 2002 18:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319085AbSHSWiu>; Mon, 19 Aug 2002 18:38:50 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:10909 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S319084AbSHSWir>; Mon, 19 Aug 2002 18:38:47 -0400
Date: Mon, 19 Aug 2002 16:42:48 -0600
Message-Id: <200208192242.g7JMgmD29241@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <Pine.LNX.4.44.0208200040010.5356-100000@localhost.localdomain>
References: <200208192236.g7JMaxS28968@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0208200040010.5356-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
> 
> On Mon, 19 Aug 2002, Richard Gooch wrote:
> 
> > > nope. Only if they use the 16-bit PID stuff in SysV IPC semaphores
> > > and message queues.
> > 
> > In other words, "yes, unless you happen not to use SysV IPC semaphores
> > or message queues in any of your binaries on your system".
> 
> no, in other words: "yes, if you use SysV IPC semaphores/semaphores
> in any of your binaries in your system, which binaries were linked
> against glibc 2.1 or older, and if you have set
> /proc/sys/kernel/pid_max to a value higher than 32K."

Ah, OK. So if I leave /proc/sys/kernel/pid_max alone, nothing will
break. Will the default ever change, or do you plan on leaving it as
is?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
