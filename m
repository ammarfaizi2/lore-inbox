Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265258AbRFUWHF>; Thu, 21 Jun 2001 18:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265259AbRFUWG4>; Thu, 21 Jun 2001 18:06:56 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:2136 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265258AbRFUWGk>; Thu, 21 Jun 2001 18:06:40 -0400
Date: Thu, 21 Jun 2001 18:06:39 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106212206.f5LM6dK12282@devserv.devel.redhat.com>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
In-Reply-To: <mailman.993156181.18994.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.993156181.18994.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no such thing as a "user mode" interrupt service routine.
> There never was one, and there will never be one on any machine
> that fetches instructions from memory for execution. [...]

If memory does not deceive me, SunLab Spring processed interrupts
in user space. I do not remember for sure, but I think QNX did, too.
User mode interrupt handlers are perfectly doable, provided that the
hardware allows to mask interrupts selectively.

Large part of the post that I quoted was spent on spitting
in the general direction of clueless programmers; indeed,
I observe that perhaps 90% of requests for user mode interrupt
processing come from the same people who would like to write
Linux kernel mode code in C++ (total retards, in other words).

It does not mean, however, that there are not justified cases
for user-mode interrupt handlers, especially outside of Linux.
Some OSes are even written in C++ and Java, and run just fine
on a machine that fetches instructions from memory.

-- Pete
