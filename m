Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSHDMbt>; Sun, 4 Aug 2002 08:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSHDMbt>; Sun, 4 Aug 2002 08:31:49 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:63497 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S317279AbSHDMbs>;
	Sun, 4 Aug 2002 08:31:48 -0400
Date: Sun, 4 Aug 2002 14:35:13 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 make allmodconfig - undefined symbols
Message-ID: <20020804123513.GC13316@alpha.home.local>
References: <29906.1028456000@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29906.1028456000@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 08:13:20PM +1000, Keith Owens wrote:
> 2.4.19 make allmodconfig.  Besides the perennial drivers/net/wan/comx.o
> wanting proc_get_inode, there was only one undefined symbol.  In the
> extremely unlikely event that binfmt_elf is a module (how do you load
> modules when binfmt_elf is a module?), smp_num_siblings is unresolved.

I also get an unresolved reference to __io_virt_debug in misc.o:puts()
when building bzImage. If you don't get it, it means that my tree is
corrupted.

Regards,
Willy
 
