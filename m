Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSKXOpW>; Sun, 24 Nov 2002 09:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbSKXOpV>; Sun, 24 Nov 2002 09:45:21 -0500
Received: from holomorphy.com ([66.224.33.161]:59787 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261495AbSKXOpT>;
	Sun, 24 Nov 2002 09:45:19 -0500
Date: Sun, 24 Nov 2002 06:49:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: akpm@digeo.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: hugetlb page patch for 2.5.48-bug fixes
Message-ID: <20021124144905.GA18063@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ed Tomlinson <tomlins@cam.org>, akpm@digeo.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <25282B06EFB8D31198BF00508B66D4FA03EA5B14@fmsmsx114.fm.intel.com> <200211240944.10660.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211240944.10660.tomlins@cam.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 09:44:10AM -0500, Ed Tomlinson wrote:
> bounds: 0000
> CPU:    0
> EIP:    0060:[i8042_exit+155901274/-1072694240]    Not tainted
> EFLAGS: 00010283
> EIP is at 0x94ae13a
> eax: dfdee040   ebx: c33151f4   ecx: c02b7ca2   edx: 094ae040
> esi: dfdce000   edi: 00000056   ebp: dfdce000   esp: dfdcfe80
> ds: 0068   es: 0068   ss: 0068
> Process kswapd0 (pid: 5, threadinfo=dfdce000 task=c151f840)
> Stack: 48094ae0 c015a7d8 c33151f4 dab225e0 c015965f c33151f4 dfdce000 0000004d
> 00000056 c015836f dab225e0 000001d0 00000000 c01586b6 00000056 c0134b5c
> 00000056 000001d0 01ee7b30 00000000 000186fe dffee760 00000212 c02b6cb4
> Call Trace:
> [iput+88/128] iput+0x58/0x80
> [prune_one_dentry+63/128] prune_one_dentry+0x3f/0x80
> [prune_dcache+175/192] prune_dcache+0xaf/0xc0
> [shrink_dcache_memory+54/64] shrink_dcache_memory+0x36/0x40
> [shrink_slab+252/352] shrink_slab+0xfc/0x160
> [balance_pgdat+243/352] balance_pgdat+0xf3/0x160
> [kswapd+291/320] kswapd+0x123/0x140

Okay, you've jumped into oblivion. What fs's were you using here?

Bill
