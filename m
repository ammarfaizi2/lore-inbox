Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbTADNQ5>; Sat, 4 Jan 2003 08:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbTADNQ5>; Sat, 4 Jan 2003 08:16:57 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:2975 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266859AbTADNQ5>;
	Sat, 4 Jan 2003 08:16:57 -0500
Date: Sun, 5 Jan 2003 00:25:10 +1100 (EST)
Message-Id: <200301041325.h04DPALr003903@supreme.pcug.org.au>
From: sfr@canb.auug.org.au
To: benh@kernel.crashing.org, davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: odd phenomenon.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@codemonkey.org.uk>
> 
> On Sat, Jan 04, 2003 at 11:48:33AM +0100, Benjamin Herrenschmidt wrote:
> 
>  > Typically happens with any kind of intense disk activity slowing down
>  > galeon's launch process. (Not only bk, but also for example updatedb
>  > running in the background).
> 
> Maybe, but bk was the only disk-thrashing type app I regularly
> have running when I've tried to reproduce this.
> 
> Is your PPC32 box SMP ?  I'm wondering why I don't see it on my
> athlon/P3 boxes, just on my dual P4.

I see this every morning on my laptop.  Anancron starts my overnight
cron jobs (mostly find across the whole disk).  So, it is not SMP
specific.  I assumed there was some sort of timeout in galeon to make
sure it starts within a particular amount of time or just aborts it.
Always works the second time.

This is on 2.4.19-pre8 (usually) (I must build a newer kernel :-)).

Cheers,
Stephen Rothwell
