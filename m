Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUHNFAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUHNFAY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 01:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUHNFAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 01:00:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:42957 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265930AbUHNFAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 01:00:22 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <411D9A2A.1000202@grupopie.com>
References: <2nrJd-7Dx-19@gated-at.bofh.it> <2ouFe-2vz-63@gated-at.bofh.it>
	 <2rfT9-5wi-17@gated-at.bofh.it> <2rF1c-6Iy-7@gated-at.bofh.it>
	 <2sxEs-46P-1@gated-at.bofh.it> <2sCkH-7i5-15@gated-at.bofh.it>
	 <2sHu9-2EW-31@gated-at.bofh.it> <m31xibtf4e.fsf@averell.firstfloor.org>
	 <20040813121502.GA18860@elte.hu> <20040813121800.GA68967@muc.de>
	 <20040813135109.GA20638@elte.hu>  <411D9A2A.1000202@grupopie.com>
Content-Type: text/plain
Message-Id: <1092459662.803.66.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 01:01:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-14 at 00:50, Paulo Marques wrote:
> Ingo Molnar wrote:
> >...
> > 
> >>With binary search you would need to backward search to find the stem
> >>for the stem compression. It's probably doable, but would be a bit
> >>ugly I guess.
> > 
> > 
> > yeah. Maybe someone will find the time to improve the algorithm. But
> > it's not a highprio thing.
> 
> Well, I found some time and decided to give it a go :)
> 

I get a few warnings:

  CC      kernel/kallsyms.o
kernel/kallsyms.c: In function `kallsyms_lookup':
kernel/kallsyms.c:99: warning: `last_0idx' might be used uninitialized in this function
kernel/kallsyms.c:101: warning: `last_0prefix' might be used uninitialized in this function

rlrevell@mindpipe:~/cvs/alsa/alsa-driver$ gcc --version
gcc (GCC) 3.3.4 (Debian 1:3.3.4-7)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Lee

