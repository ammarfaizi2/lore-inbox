Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267378AbSLERdV>; Thu, 5 Dec 2002 12:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267379AbSLERdU>; Thu, 5 Dec 2002 12:33:20 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63752 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267378AbSLERdU>; Thu, 5 Dec 2002 12:33:20 -0500
Date: Thu, 5 Dec 2002 12:39:10 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Robert Love <rml@tech9.net>
cc: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deprecate use of bdflush()
In-Reply-To: <1039018361.1505.7.camel@phantasy>
Message-ID: <Pine.LNX.3.96.1021205122453.18090E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Dec 2002, Robert Love wrote:

> On Wed, 2002-12-04 at 08:10, Daniel Kobras wrote:
> 
> > > Bdflush the user-space daemon went away a long time ago, ~1995.
> > 
> > sys_bdflush() is still usable in 2.4 to tune kupdated's parameters.
> > Only func==1 functionality is long gone.
> 
> Right.  But the bdflush daemon was gone in 2.4.

It's not *gone* it's just moved into the kernel...
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY  TIME COMMAND
  1     0     5     1  15   0     0    0 bdflus SW   ?    0:00 [bdflush]

Clearly it doesn't need the syscall interface, so as long as there's a way
to tune useful parameters the interface isn't needed. Don't know why I
thought I was doing stuff using that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

