Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264247AbSIVNyU>; Sun, 22 Sep 2002 09:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264251AbSIVNyU>; Sun, 22 Sep 2002 09:54:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28422 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264247AbSIVNyT>; Sun, 22 Sep 2002 09:54:19 -0400
Date: Sun, 22 Sep 2002 09:38:52 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020920215029.GB1527@gnuppy.monkey.org>
Message-ID: <Pine.LNX.3.96.1020922093417.6569A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Bill Huey wrote:


> Don't remember off hand, but it's like to be several times a second which is
> often enough to be a problem especially on large systems with high load.
> 
> The JVM with incremental GC is being targetted for media oriented tasks
> using the new NIO, 3d library, etc... slowness in safepoints would cripple it
> for these tasks. It's a critical item and not easily address by the current
> 1:1 model.

Could you comment on how whell this works (or not) with linuxthreads,
Solaris, and NGPT? I realize you probably haven't had time to look at NPTL
yet. If an N:M model is really better for your application you might be
able to just run NGPT.

Since preempt threads seem a problem, cound a dedicated machine run w/o
preempt? I assume when you say "high load" that you would be talking a
server, where performance is critical.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

