Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282922AbRK0UAS>; Tue, 27 Nov 2001 15:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282923AbRK0UAK>; Tue, 27 Nov 2001 15:00:10 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:9224 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282922AbRK0T77>; Tue, 27 Nov 2001 14:59:59 -0500
Date: Tue, 27 Nov 2001 14:53:23 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Paul G. Allen" <pgallen@randomlogic.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon: Kernel 2.4.14 IDE problems
In-Reply-To: <3BFA4F69.D7560BDE@randomlogic.com>
Message-ID: <Pine.LNX.3.96.1011127145139.31174C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Paul G. Allen wrote:

> I just compiled and installed a vanilla 2.4.14 kernel (nope, I haven't
> tweaked this one yet :). Just as a reminder, I have a Tyan Thunder K7
> with 2 1.4GHz Athlons (_NOT_ MP or XP). It has an IBM DTLA-307030
> Ultra100 IDE drive on the Ultra100 IDE interface.
> 
> The kernel seems to boot with DMA enabled for this drive which causes
> frequent system lockups. This is the same problem I had with kernels
> through 2.4.9 (including the ac series). Disabling DMA (hdparm -d0
> /dev/hda) solves the problem.

Paul, just as a thought, is the 32 bit interface enabled on that drive? I
dimly remember that trying to run DMA through a 16 bit (default?)
interface could result in a learning experience. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

