Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319069AbSHSWna>; Mon, 19 Aug 2002 18:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319087AbSHSWna>; Mon, 19 Aug 2002 18:43:30 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:13469 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S319069AbSHSWn3>; Mon, 19 Aug 2002 18:43:29 -0400
Date: Mon, 19 Aug 2002 16:47:30 -0600
Message-Id: <200208192247.g7JMlUM29487@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <1029796863.942.1.camel@phantasy>
References: <200208192231.g7JMVQI28575@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0208200033400.5253-100000@localhost.localdomain>
	<200208192236.g7JMaxS28968@vindaloo.ras.ucalgary.ca>
	<1029796863.942.1.camel@phantasy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes:
> On Mon, 2002-08-19 at 18:36, Richard Gooch wrote:
> 
> > In other words, "yes, unless you happen not to use SysV IPC semaphores
> > or message queues in any of your binaries on your system". So you want
> > to break binary compatibility. Please don't. I don't want to downgrade
> > to glibc.
> 
> So are you saying we can never deprecate interfaces, just so you can
> continue using libc5?

Having a stable ABI to user-space has been one of the strong points of
Linux, versus just about everything else out there. And I wouldn't be
using libc 5 if glibc wasn't growing exponentially with time (both in
terms of total bytes and in terms of number of shared libraries I have
to add to my link line).

> Seems saner to keep libc5 in sync with the kernel than vice versa..

It's not just me. There are people using libc 4.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
