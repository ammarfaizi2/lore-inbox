Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312998AbSDJMxE>; Wed, 10 Apr 2002 08:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313026AbSDJMxD>; Wed, 10 Apr 2002 08:53:03 -0400
Received: from [62.221.7.202] ([62.221.7.202]:26506 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312998AbSDJMxD>; Wed, 10 Apr 2002 08:53:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [brokenpatch] page accounting 
In-Reply-To: Your message of "Wed, 10 Apr 2002 04:01:59 MST."
             <3CB41BA7.DAC3A785@zip.com.au> 
Date: Wed, 10 Apr 2002 22:56:04 +1000
Message-Id: <E16vHdt-0001QU-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3CB41BA7.DAC3A785@zip.com.au> you write:
> Problem is, I just converted it to use the new per-CPU code
> and it broke.  The numbers aren't correct.  It worked fine
> with open-coded per-CPU accumulators.  Rusty, can you spot
> the error?

Can't see it.  Dump each one (0 ... NR_CPUS-1) and see where the
counters are actually going?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
