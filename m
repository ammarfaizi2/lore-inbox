Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267729AbTAMD1D>; Sun, 12 Jan 2003 22:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267756AbTAMD1D>; Sun, 12 Jan 2003 22:27:03 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17423 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267729AbTAMD07>; Sun, 12 Jan 2003 22:26:59 -0500
Date: Sun, 12 Jan 2003 22:33:07 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jean-Daniel Pauget <jd@disjunkt.com>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre3-ac2
In-Reply-To: <Pine.LNX.4.51.0301100021050.5467@mint>
Message-ID: <Pine.LNX.3.96.1030112222243.17657C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Jean-Daniel Pauget wrote:

> 
>     I had some strange bug using 2.4.21pre3-ac2 :
>     at rebooting after a freeze (my machine freezes from time to time
>     whatever the kernel is, I'm still diging that point)
>     fsck.ext2 was not able to finish checking my /home (59Gb), it
>     systematically got a signal 11 (I tried several times).
> 
>     rebooting using my previous kernel (2.4.20 with a minor patch for the
>     i845G AGP mess-up) was enough so that the fsck worked fine at the first
>     attempt with this kernel.

There are several possibilities, but I would suspect you have memory which
is just marginal, and with some combination of access patterns you trigger
a sig 11 problem. I have the same board, with 72 bit ECC capable memory,
and I'm running all of the BIOS speed options (section 4.4 of the manual)
set at default, rather than tuning for any extra bit of performance.

If you have pushed any of the CPU or memory speeds, obviously that's a
place to return to default, but I suspect what you have is marginal
memory. Best is to borrow a stick and run on other memory, 2nd best is to
slow the speeds a bit and see if that works better.

Clearly this is only an educated guess.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

