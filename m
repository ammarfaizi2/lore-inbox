Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264618AbSKDCKB>; Sun, 3 Nov 2002 21:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264620AbSKDCKB>; Sun, 3 Nov 2002 21:10:01 -0500
Received: from holomorphy.com ([66.224.33.161]:50833 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264618AbSKDCKB>;
	Sun, 3 Nov 2002 21:10:01 -0500
Date: Sun, 3 Nov 2002 18:15:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Tim Connors <tconnors@astro.swin.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: small memory machine, large reserved memory
Message-ID: <20021104021509.GS23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Tim Connors <tconnors@astro.swin.edu.au>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0211041304010.16003-100000@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211041304010.16003-100000@hexane.ssi.swin.edu.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 01:10:36PM +1100, Tim Connors wrote:
> In light of the recent discussions about config_tiny, etc, I decided to
> install 2.4.19 on my old 8MB 486, to see whether it performed any better
> than my previous attempts with 2.2.* and 2.4.*
> The strange thing is, the memory init line at bootup (eg Memory:
> 255296k/261996k available (1584k kernel code, 5972k reserved, 1353k data
> , 108k init, 0k highmem)) says that only about 5 or 6MB are availabel,
> with a whopping 2.x MB reserved. I have done a web search, and the only
> answer I have come up with is that the top 384kb of the 1MB lower
> portion of RAM should be here, but what else could be eating up all my
> RAM?
> There is nothgin suspicious in the BIOS - all BIOS and video caching is
> turned off. The machine only (natually) has ISA slots in it, most are
> empty. What else could possibly be wrong?
> Is there something I can hack in the kernel to get it to use that, or can
> anyone give me pointers as to what else I can change? I would really love
> to regain that 2MB - its a pain when the shell gets swapped out after
> doing an `ls` :)

How does 2.5.44 (or 2.5.x-bk) do?


Bill
