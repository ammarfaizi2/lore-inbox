Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319076AbSHSWgj>; Mon, 19 Aug 2002 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319077AbSHSWgj>; Mon, 19 Aug 2002 18:36:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:45255 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319076AbSHSWgj>;
	Mon, 19 Aug 2002 18:36:39 -0400
Date: Tue, 20 Aug 2002 00:41:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <200208192236.g7JMaxS28968@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0208200040010.5356-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Richard Gooch wrote:

> > nope. Only if they use the 16-bit PID stuff in SysV IPC semaphores
> > and message queues.
> 
> In other words, "yes, unless you happen not to use SysV IPC semaphores
> or message queues in any of your binaries on your system".

no, in other words: "yes, if you use SysV IPC semaphores/semaphores in any
of your binaries in your system, which binaries were linked against glibc
2.1 or older, and if you have set /proc/sys/kernel/pid_max to a value
higher than 32K."

	Ingo

