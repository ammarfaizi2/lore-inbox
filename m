Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262264AbTC1H6I>; Fri, 28 Mar 2003 02:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbTC1H6I>; Fri, 28 Mar 2003 02:58:08 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:58363
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262264AbTC1H6I>; Fri, 28 Mar 2003 02:58:08 -0500
Date: Fri, 28 Mar 2003 03:05:42 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 64GB NUMA-Q after pgcl
In-Reply-To: <20030328075730.GP30140@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0303280303190.2884-100000@montezuma.mastecende.com>
References: <20030328040038.GO1350@holomorphy.com>
 <Pine.LNX.4.50.0303280243080.2884-100000@montezuma.mastecende.com>
 <20030328075730.GP30140@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, William Lee Irwin III wrote:

> Sure. On NUMA-Q mem_map[] is not allocated using bootmem except for
> node 0. Various other bootmem allocations are also proportional to
> memory as measured in units of PAGE_SIZE, but not all.
> 
> So all we're seeing here is node 0's mem_map[] with "miscellaneous"
> bootmem allocations thrown in, whether reduced or increased.
> 
> This is not very reflective of what's going on as the majority of mem_map[]
> is allocated through a custom reservation mechanism as opposed to bootmem.

Thanks, nice work btw, although the core guts of this stuff is somewhat of 
a mystery to some of us ;)

	Zwane
-- 
function.linuxpower.ca
