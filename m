Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315421AbSEQEtY>; Fri, 17 May 2002 00:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSEQEtX>; Fri, 17 May 2002 00:49:23 -0400
Received: from holomorphy.com ([66.224.33.161]:27561 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315421AbSEQEtV>;
	Fri, 17 May 2002 00:49:21 -0400
Date: Thu, 16 May 2002 21:47:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Mel <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updated Commentry Patches
Message-ID: <20020517044748.GP7076@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mel <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205170429130.29254-100000@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.19pre8_page_alloc_commentry
> http://www.csn.ul.ie/~mel/projects/vm/patches/2.4.19pre8_page_alloc_commentry
>   This extends the documentation on page_alloc.c to describe how the buddy
>   allocator works

One way to describe the bit toggling behavior is saying that each page
has a "virtual bit", the bit present in the bitmap is the xor of the
"virtual bits" of the two buddies, and the buddy's bit is recovered by
xor'ing with the bit of the page we're examining, which is known from
the entry point.


Cheers,
Bill
