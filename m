Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288568AbSANBeU>; Sun, 13 Jan 2002 20:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288575AbSANBeM>; Sun, 13 Jan 2002 20:34:12 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:37127 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288568AbSANBd5>; Sun, 13 Jan 2002 20:33:57 -0500
Date: Sun, 13 Jan 2002 20:33:48 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Balanced Multi Queue Scheduler ...
In-Reply-To: <200112301951.fBUJoxSr011753@svr3.applink.net>
Message-ID: <Pine.LNX.3.96.1020113203203.17441M-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Timothy Covell wrote:

> Ummm, on my Dual P-III (650MHz with 524988416 Bytes), my current Seti 
> efficiency is 5.35 CpF.   That's a tad high/slower than an Ultra Sparc IIi 
> according to their stats.  So, it would appear that being SMP is hurting my 
> performance a bit.   Unless that is that you meant to run a seti instance for 
> each CPU?   And this reminds me of how "make -j3 bzlilo" is slower than
> "make -j2 bzlilo".

make -j3 bzlilo
make bzlilo MAKE='make -j3'

See if it runs differently on your machine, mem size may matter.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

