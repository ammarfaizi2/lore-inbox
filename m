Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSLFNqP>; Fri, 6 Dec 2002 08:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSLFNqO>; Fri, 6 Dec 2002 08:46:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:16650 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262662AbSLFNqO>; Fri, 6 Dec 2002 08:46:14 -0500
Date: Fri, 6 Dec 2002 08:52:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Con Kolivas <conman@kolivas.net>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]2.4.19-ck7
In-Reply-To: <200212061737.36906.conman@kolivas.net>
Message-ID: <Pine.LNX.3.96.1021206084913.23051A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Con Kolivas wrote:

> I've gone back and looked at ck7 (was a little while ago). -ck doesnt directly 
> alter skbuff.c but may be responsible for calling it in an interrupt. I'm 
> sorry I can't enlighten you as to why it's happening and offer a fix as I 
> don't really know what the problem is.
> 
> The fact that it's happening now regularly and not previously is unusual if 
> the kernel itself is responsible unless some pattern in your usage has 
> changed. Perhaps seeing if the problem repeats on a vanilla or alternate 
> kernel may be helpful (-ck is rather different from vanilla).

I suspect that the network load is getting high enough to travel new code
paths, it's pushing ~200MB/s 24x7, and I'm sure we get some peaks as well.
Just thought it might be useful, I will be going to something newer next
week.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

