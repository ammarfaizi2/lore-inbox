Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312505AbSCUV2h>; Thu, 21 Mar 2002 16:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312506AbSCUV21>; Thu, 21 Mar 2002 16:28:27 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28941 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312505AbSCUV2N>; Thu, 21 Mar 2002 16:28:13 -0500
Date: Thu, 21 Mar 2002 16:26:11 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Bob Miller <rem@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.7 acct.c oops
In-Reply-To: <20020321113829.A1543@doc.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1020321162155.18421A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Bob Miller wrote:

> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 02/03/21	rem@doc.pdx.osdl.net	1.538
> # Fixed acct.c code by removing the BUG_ON code because it doesn't work
> # on UP systems.
> # --------------------------------------------

  Please help my education... after looking at the code, I don't see why
the BUG_ON was removed rather than made dependent on SMP, assuming that
the BK comment and my hasty reading of code actually mean that it did work
for SMP.

  Is this a solid "can't happen" now and no test needed, or is a better
test in the works, or ???

  I didn't try to compile it, so there may be something I'm totally
missing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

