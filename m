Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbTA0Ll5>; Mon, 27 Jan 2003 06:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTA0Ll5>; Mon, 27 Jan 2003 06:41:57 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58376 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267176AbTA0Ll5>; Mon, 27 Jan 2003 06:41:57 -0500
Date: Mon, 27 Jan 2003 06:48:26 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.59 Same problems as 55..58
In-Reply-To: <200301261440.PAA08520@harpo.it.uu.se>
Message-ID: <Pine.LNX.3.96.1030127064020.25678A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2003, Mikael Pettersson wrote:

> On Sat, 25 Jan 2003 18:26:29 -0500 (EST), Bill Davidsen wrote:
> >WARNING: /lib/modules/2.5.59/kernel/drivers/net/8390.ko needs unknown symbol crc32_le
> >WARNING: /lib/modules/2.5.59/kernel/drivers/net/8390.ko needs unknown symbol bitreverse
> >  .
> >  . And this problem I've noted since 2.5.55
> 
> If your module-init-tools are older than 0.9.8, then this message
> is expected. depmod doesn't find GPL only symbols. Fixed in 0.9.8.

I was on 0.9.9pre infortunately, but thanks much for the suggestion. I've
been keeping reasonably current, in hopes of solutions to other issues. I
suspect that this is caused by having CRC32 built-in instead of as a
module or vice-versa. I just ran out of time to test all possible
combinations.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

