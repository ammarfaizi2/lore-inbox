Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282483AbRKZUHW>; Mon, 26 Nov 2001 15:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282463AbRKZUFx>; Mon, 26 Nov 2001 15:05:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51975 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282480AbRKZUFM>; Mon, 26 Nov 2001 15:05:12 -0500
Date: Mon, 26 Nov 2001 14:58:49 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Loop.c File !!!!
In-Reply-To: <EXCH01SMTP011vDfrwV0000fda4@smtp.netcabo.pt>
Message-ID: <Pine.LNX.3.96.1011126145531.27112D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Miguel Maria Godinho de Matos wrote:

> The problem is the following:
> 
> I AM A NEWBIE!!! 
> 
> Well i had some questions about the linux kernel compilation and some of you 
> gave me some real goos answeres, however, there is an issue which keeps 
> buzzing my head and that i can't understand!
> 
> Some one told me i should edit the loop.c file and even tried to explained me 
> why but i couldn't understand.
> 
> He said something about my new kernel wouldn't be able to compile if two or 
> three lines weren't comented!
> 
> I didn't understand this fact so i would like to know why should i edit the 
> /usr/src/linux/drivers/block/loop.c file!!!!

You should edit out those lines because your kernel will not compile
unless you do so.

Those lines are not supposed to be there and need to be removed. They are
left over from an earlier version of the kernel and are not only not
required but prevent compilation. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

