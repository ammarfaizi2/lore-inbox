Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319071AbSHSW12>; Mon, 19 Aug 2002 18:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319069AbSHSW12>; Mon, 19 Aug 2002 18:27:28 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:2205 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S319063AbSHSW11>; Mon, 19 Aug 2002 18:27:27 -0400
Date: Mon, 19 Aug 2002 16:31:26 -0600
Message-Id: <200208192231.g7JMVQI28575@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: MAX_PID changes in 2.5.31
In-Reply-To: <Pine.LNX.4.44.0208192146580.32337-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208192146580.32337-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
> 
> Linus,
> 
> afaics, you did the PID_MAX changes in v2.5.31? This is a change i had for
> (surprise) threading purposes already, but done a bit differently.
> 
> The main problem is that there's the old-style SysV IPC interface
> that uses 16-bit PIDs still. All recent SysV applications (linked
> against glibc 2.2 or newer) use IPC_64, but any application linked
> against pre-2.2 glibcs will fail. glibc 2.2 was released 2 years
> ago, is this enough of a timeout to obsolete the non-IPC_64
> interfaces?

Are you saying that people running libc 5 or even glibc 2.1 will
suddenly have their code broken?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
