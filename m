Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312330AbSCTK7f>; Wed, 20 Mar 2002 05:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312331AbSCTK70>; Wed, 20 Mar 2002 05:59:26 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36620 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312330AbSCTK7S>; Wed, 20 Mar 2002 05:59:18 -0500
Date: Wed, 20 Mar 2002 05:56:52 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-110-zone_accounting
In-Reply-To: <3C9808EE.B5C38E84@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020320055414.6098A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Andrew Morton wrote:

> 4: The use of the per-classzone counters was introduced in
>    aa-096-swap_out.  This match actually makes them right, and the VM
>    starts working again.

Might be desirable to merge these into a single patch. The 096 and 110
patches are two sides of a single coin as newrly as I can tell.

Just my opinion, to prevent any possibility of someone using one without
the other and winding up without functional VM.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

