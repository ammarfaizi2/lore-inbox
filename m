Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291345AbSBMESA>; Tue, 12 Feb 2002 23:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291346AbSBMERw>; Tue, 12 Feb 2002 23:17:52 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:31751 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291345AbSBMERi>; Tue, 12 Feb 2002 23:17:38 -0500
Date: Tue, 12 Feb 2002 23:15:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] disk read latency update
In-Reply-To: <3C69A708.FDDA6097@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020212231228.8017F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Andrew Morton wrote:

> Updates the elevator changes to sync with the version
> which is in the latest -rmap patch.
> 
> This may complicate future merging with Rik; the easiest
> approach will be to just drop any ll_rw_blk.c and elevator.c
> chunks when merging up -rmap.

  I hope that will not be true... if these work as well as they should I
could hope Rik would adopt them. The theory seems clearly a win, I haven't
read the code in detail to be sure there aren't any jackpot cases where an
extend passes a cylinder boundary.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

