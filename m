Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbSIPSUk>; Mon, 16 Sep 2002 14:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbSIPSUk>; Mon, 16 Sep 2002 14:20:40 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7437 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262773AbSIPSUj>; Mon, 16 Sep 2002 14:20:39 -0400
Date: Mon, 16 Sep 2002 14:18:27 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] thread-exec-2.5.34-B1, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209152055290.9822-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020916141348.6180A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Ingo Molnar wrote:


> ok. libpthreads uses an internal clone() for posix_spawn() [which does
> what your example illustrates] which should be a tad faster than vfork() -
> but vfork() should work just as well.

Is this "libpthreads" the old one used in 2.4 distros, a recent version of
NGPT, or something else? I hope 2.5 will work with NGPT or better, and not
depend on the old library!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

