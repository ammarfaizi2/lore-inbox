Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263177AbRE1WJz>; Mon, 28 May 2001 18:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263179AbRE1WJp>; Mon, 28 May 2001 18:09:45 -0400
Received: from mailb.telia.com ([194.22.194.6]:57869 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S263177AbRE1WJe>;
	Mon, 28 May 2001 18:09:34 -0400
Date: Tue, 29 May 2001 00:10:03 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <anedah-9@sm.luth.se>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac2
Message-ID: <20010529001003.A320@sm.luth.se>
Mail-Followup-To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0105281636160.1261-100000@freak.distro.conectiva> <20010528234225.A4362@sm.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010528234225.A4362@sm.luth.se>
User-Agent: Mutt/1.3.18i
X-Unexpected-Header: The Spanish Inquisition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

André Dahlqvist <anedah-9@sm.luth.se> wrote:

> I agree. Kernels after 2.4.4 uses a *lot* more swap for me, which I guess
> might be part of the reason for the slowdown.

Following up on myself, here are some numbers:

Freshly booted 2.4.4 with X and Mozilla running, 'free' outputs this:

             total       used       free     shared    buffers     cached
Mem:         62716      61280       1436          0       1820      28704
-/+ buffers/cache:      30756      31960
Swap:       160608          0     160608

Freshly booted 2.4.5-ac2 with X and Mozilla running, 'free' outputs this:

             total       used       free     shared    buffers     cached
Mem:         62784      61784       1000        380       1824      35748
-/+ buffers/cache:      24212      38572
Swap:       160608       7128     153480

After running 2.4.5-ac2 (and other kernels after vanilla 2.4.4) for a while
the swap usage grows a lot, to around 60 MB. Older kernels didn't swap out
this aggressively in my experience.

This is on a 233 Mhz box with 64 megs of RAM.
-- 

André Dahlqvist <anedah-9@sm.luth.se>
