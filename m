Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSG1VNV>; Sun, 28 Jul 2002 17:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSG1VNU>; Sun, 28 Jul 2002 17:13:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6126 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317363AbSG1VNU>;
	Sun, 28 Jul 2002 17:13:20 -0400
Date: Sun, 28 Jul 2002 23:15:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: inlines in kernel/sched.c
In-Reply-To: <3D445F53.BDE6B754@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207282309430.5116-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Jul 2002, Andrew Morton wrote:

> Ingo, could you please review the use of inlines in the
> scheduler sometime?  They seem to be excessive.
> 
> For example, this patch reduces the sched.d icache footprint
> by 1.5 kilobytes.

the patch also hurts context-switch latencies - it went
from 1.35 usecs to 1.42 usecs - a 5% drop.

	Ingo

