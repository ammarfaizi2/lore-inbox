Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314747AbSEHQ6I>; Wed, 8 May 2002 12:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314748AbSEHQ6H>; Wed, 8 May 2002 12:58:07 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19217 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314747AbSEHQ6H>; Wed, 8 May 2002 12:58:07 -0400
Date: Wed, 8 May 2002 12:54:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Clifford White <ctwhite@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: x86 question: Can a process have > 3GB memory?
In-Reply-To: <E175ESI-0000PX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1020508124801.3449C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, Alan Cox wrote:

> Remember DOS and EMM memory expansion. Basically that is what you come
> down to. Allocate multiple large shared memory segments, attach the one
> you need each time and implement software segment swapping.

  I remember doing bank switching on IEEE-696 (S-100) system for both
programs and "ramdisk," when 64K (sic) was a lot of memory.
 
> That should have you diving for an AMD hammer or IA64 box as soon as they
> come out 8)

  At the moment Itanium is shipping, it makes up for being expensive by
also being slow ;-) However, Sun will sell you a 64bit UltraSPARC system
with everything but monitor for <$1K. Add a few GB and load Linux. I
*think* you can order with Linux preloaded now, but don't quote me on
that. It's not blindingly fast but it's blindingly cheap.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

