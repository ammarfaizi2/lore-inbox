Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311123AbSCMToL>; Wed, 13 Mar 2002 14:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311119AbSCMToC>; Wed, 13 Mar 2002 14:44:02 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55049 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311123AbSCMTnm>; Wed, 13 Mar 2002 14:43:42 -0500
Date: Wed, 13 Mar 2002 14:41:52 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Martin Wirth <Martin.Wirth@dlr.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <3C8F1801.6070107@dlr.de>
Message-ID: <Pine.LNX.3.96.1020313143751.4797A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Martin Wirth wrote:

> The normal way to use multithreading under UNIX is the pthread
> library. Here the condition variables are the equivalent to kernel
> wait queues. So I think to really implement a fast pthread lib based
> on futexes one needs some means to implement condition variables
> (with synchronous futex release to implement  pthread_cond_wait(..)!).

Let me mention this again... The IBM release of NGPT states that Linus has
approved the inclusion of the NGPT patches in the mainline kernel. Will
this be in 2.4.19 release? I've been running 2.4.17 for NGPT, haven't
tried 2.4.19 other than to see the patch didn't apply).

(NGPT = Next Generation Pthreads, a cleaner and faster POSIX threads)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

