Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292304AbSBYUJy>; Mon, 25 Feb 2002 15:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292276AbSBYUJr>; Mon, 25 Feb 2002 15:09:47 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24337 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290926AbSBYUHv>; Mon, 25 Feb 2002 15:07:51 -0500
Date: Mon, 25 Feb 2002 15:06:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Cesar Suga <sartre@linuxbr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HPT366: DMA errors?
In-Reply-To: <Pine.LNX.4.40.0202212304240.438-100000@sartre.linuxbr.com>
Message-ID: <Pine.LNX.3.96.1020225150255.17391F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Cesar Suga wrote:

> 	And, in kernel messages, whilst doing hdparm -tT /dev/hde3:
> 
> ->	invalidate: busy buffer
> 	(from fs/buffer.c)
> 
> 	(yes, it is wrong to use hde3, but when I use hde, but whatever;
> using hda3 or hda did not matter when I used this *same* HDD with normal
> IDE cable (not using HPT366))
> 
> 	I am not using *any* special features (untuned HDD), drive was set
> to DMA mode 4 at the HPT BIOS.

  My though would be that when something is working right, the first step
is to check that you are doing things in a known safe way. Therefore I
would (a) use /dev/hde, and (b) set -X34 with hdparm.

  I do those things, I have two internal systems working and two at
client sites, which I assume are working since they aren't teling me
otherwise.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

