Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319075AbSHSWdA>; Mon, 19 Aug 2002 18:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319076AbSHSWdA>; Mon, 19 Aug 2002 18:33:00 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:7325 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S319075AbSHSWc7>; Mon, 19 Aug 2002 18:32:59 -0400
Date: Mon, 19 Aug 2002 16:36:59 -0600
Message-Id: <200208192236.g7JMaxS28968@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain>
References: <200208192231.g7JMVQI28575@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
> 
> On Mon, 19 Aug 2002, Richard Gooch wrote:
> 
> > Are you saying that people running libc 5 or even glibc 2.1 will
> > suddenly have their code broken?
> 
> nope. Only if they use the 16-bit PID stuff in SysV IPC semaphores
> and message queues.

In other words, "yes, unless you happen not to use SysV IPC semaphores
or message queues in any of your binaries on your system". So you want
to break binary compatibility. Please don't. I don't want to downgrade
to glibc.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
