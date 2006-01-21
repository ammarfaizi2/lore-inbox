Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWAUNUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWAUNUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 08:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWAUNUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 08:20:19 -0500
Received: from mail.gmx.net ([213.165.64.21]:50080 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932181AbWAUNUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 08:20:19 -0500
X-Authenticated: #7258287
Subject: Re: [BUG] at mm/slab.c:1235! (Version 2.6.15)
From: Sven Lauritzen <the-pulse@gmx.net>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0601181547580.20218@sbz-30.cs.Helsinki.FI>
References: <1137582956.1774.15.camel@berlin.slsd>
	 <84144f020601180422q78ecdf37mb8b8e9d1f40039d1@mail.gmail.com>
	 <1137591682.1774.35.camel@berlin.slsd>
	 <Pine.LNX.4.58.0601181547580.20218@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 14:20:15 +0100
Message-Id: <1137849615.1764.8.camel@berlin.slsd>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, 2006-01-18 at 15:54 +0200, Pekka J Enberg wrote:
> Indeed that's because the kernel starts reclaiming memory and attempts to 
> shrink the slabs. It's just that the page we're freeing is being managed 
> by the slab allocator and I don't see how anyone else could be messing 
> around with it. The fact that it's one bit error makes me think it could 
> be due to faulty memory.

I have run memtest for 15 hours now, - no errors. Im running the kernel
with CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC enabled. Until now, no
more Bugs or Oopses occured.

I don't know if there's any way to reproduce the problem, but at least
I'll keep my eyes open.

Sven
-- 
Sven Lauritzen
--------------------------------------------------------------------
mailto:the-pulse@gmx.net

pub 1024D/95C9A892                  sub 1024g/D30E490F ABCDEFGHIJKLM
Fp  2FA9 FC9B 078C 5BC7 87DC  0B0D 2329 94F6 95C9 A892 NOPQRSTUVWXYZ
--------------------------------------------------------------------

