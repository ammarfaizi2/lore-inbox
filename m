Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131351AbRCUMcT>; Wed, 21 Mar 2001 07:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131352AbRCUMcK>; Wed, 21 Mar 2001 07:32:10 -0500
Received: from linuxcare.com.au ([203.29.91.49]:40714 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131351AbRCUMcA>; Wed, 21 Mar 2001 07:32:00 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Wed, 21 Mar 2001 23:27:02 +1100
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pagecache SMP-scalability patch [was: spinlock usage]
Message-ID: <20010321232701.A16455@linuxcare.com>
In-Reply-To: <20010321180607.A11941@linuxcare.com> <Pine.LNX.4.30.0103211301530.5270-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.30.0103211301530.5270-100000@elte.hu>; from mingo@elte.hu on Wed, Mar 21, 2001 at 01:11:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

>   http://people.redhat.com/~mingo/smp-pagecache-patches/pagecache-2.4.2-H1
> 
> this patch splits up the main scalability offender in non-RAM-limited
> dbench runs, which is pagecache_lock. The patch was designed and written
> by David Miller, and is being forward ported / maintained by me. (The new
> pagecache lock design is similar to TCP's hashed spinlocks, which proved
> to scale excellently.)

Thanks Ingo! Davem told me about this a while ago but I had forgotten
about it. I'll do some runs tomorrow including ones which dont fit in
RAM.

> (about lstat(): IMO lstat() should not call into the lowlevel FS code.)

Ooops, sorry I meant stats as in statistics :)

Anton
