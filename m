Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268665AbUHTSvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268665AbUHTSvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbUHTSsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:48:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12440 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266627AbUHTSq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:46:56 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm3
Date: Fri, 20 Aug 2004 14:46:11 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com>
In-Reply-To: <200408201144.49522.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201446.11409.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 11:44 am, Jesse Barnes wrote:
> On Friday, August 20, 2004 6:19 am, Andrew Morton wrote:
> > - This is (very) lightly tested.  Mainly a resync with various parties.
>
> Woo-hoo!  This boots *without changes* on a 512p Altix!  Now to re-run the
> profiles and try wli's new per-cpu profiling buffers.

With some minor niggles of course (I thought these were fixed awhile ago?).

Jesse

NET: Registered protocol family 2
IP: routing cache hash table of 8388608 buckets, 131072Kbytes
swapper: page allocation failure. order:17, mode:0x20

Call Trace:
 [<a0000001000193a0>] show_stack+0x80/0xa0
                                sp=e0000930037a7c40 bsp=e0000930037a1150
 [<a0000001001140e0>] __alloc_pages+0x620/0x9a0
                                sp=e0000930037a7e10 bsp=e0000930037a10c0
 [<a000000100151240>] alloc_page_interleave+0x100/0x1e0
                                sp=e0000930037a7e20 bsp=e0000930037a1090
 [<a0000001001144a0>] __get_free_pages+0x40/0x100
                                sp=e0000930037a7e20 bsp=e0000930037a1068
 [<a00000010073e9c0>] tcp_init+0x2c0/0x800
                                sp=e0000930037a7e20 bsp=e0000930037a1030
 [<a00000010073fe10>] inet_init+0x330/0x3c0
                                sp=e0000930037a7e30 bsp=e0000930037a0ff0
 [<a00000010070d070>] do_initcalls+0xb0/0x1e0
                                sp=e0000930037a7e30 bsp=e0000930037a0f88
 [<a000000100009780>] init+0x100/0x440
                                sp=e0000930037a7e30 bsp=e0000930037a0f48
 [<a00000010001b130>] kernel_thread_helper+0xd0/0x100
                                sp=e0000930037a7e30 bsp=e0000930037a0f20
 [<a000000100009060>] start_kernel_thread+0x20/0x40
                                sp=e0000930037a7e30 bsp=e0000930037a0f20
swapper: page allocation failure. order:16, mode:0x20

Call Trace:
 [<a0000001000193a0>] show_stack+0x80/0xa0
                                sp=e0000930037a7c40 bsp=e0000930037a1150
 [<a0000001001140e0>] __alloc_pages+0x620/0x9a0
                                sp=e0000930037a7e10 bsp=e0000930037a10c0
 [<a000000100151240>] alloc_page_interleave+0x100/0x1e0
                                sp=e0000930037a7e20 bsp=e0000930037a1090
 [<a0000001001144a0>] __get_free_pages+0x40/0x100
                                sp=e0000930037a7e20 bsp=e0000930037a1068
 [<a00000010073e9c0>] tcp_init+0x2c0/0x800
                                sp=e0000930037a7e20 bsp=e0000930037a1030
 [<a00000010073fe10>] inet_init+0x330/0x3c0
                                sp=e0000930037a7e30 bsp=e0000930037a0ff0
 [<a00000010070d070>] do_initcalls+0xb0/0x1e0
                                sp=e0000930037a7e30 bsp=e0000930037a0f88
 [<a000000100009780>] init+0x100/0x440
                                sp=e0000930037a7e30 bsp=e0000930037a0f48
 [<a00000010001b130>] kernel_thread_helper+0xd0/0x100
                                sp=e0000930037a7e30 bsp=e0000930037a0f20
 [<a000000100009060>] start_kernel_thread+0x20/0x40
                                sp=e0000930037a7e30 bsp=e0000930037a0f20
TCP: Hash tables configured (established 33554432 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
