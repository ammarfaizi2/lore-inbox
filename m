Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289840AbSAWN2K>; Wed, 23 Jan 2002 08:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289844AbSAWN2A>; Wed, 23 Jan 2002 08:28:00 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:2538 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S289840AbSAWN1q>; Wed, 23 Jan 2002 08:27:46 -0500
Date: Wed, 23 Jan 2002 08:31:14 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: pre4aa1 contig kmaps patch
Message-ID: <20020123083114.A130@earthlink.net>
In-Reply-To: <20020121191539.K8292@athlon.random> <Pine.LNX.4.21.0201221813430.1130-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0201221813430.1130-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Jan 22, 2002 at 07:29:08PM +0000
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 07:29:08PM +0000, Hugh Dickins wrote:
> 
> It didn't boot in my 1GB user virtual, 2GB physical memory,
> PAE testing (yes, PAE with <= 4GB physical memory is not optimal,
> but should work for testing).  I was confused when I tried that,

What I found is with 2.4.18pre4aa1 vanilla, when CONFIG_2G=y and
CONFIG_HIGHMEM=y, my system stops booting with:

Uncompressing Linux... Ok, booting the kernel.

With Hugh's patch, 2.4.18pre4aa1 will boot with CONFIG_2G=y 
and CONFIG_HIGHMEM=y, which is good.

In my previous testing with the 1-2-3-gb patch, I always 
had CONFIG_NOHIGHMEM=y.

Based on these findings, I think inclusion of Hugh's patch
is a good thing.
-- 
Randy Hron

