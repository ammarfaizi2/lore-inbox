Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292400AbSCDOuU>; Mon, 4 Mar 2002 09:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292399AbSCDOuB>; Mon, 4 Mar 2002 09:50:01 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:61315 "EHLO
	gull.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S292395AbSCDOtz>; Mon, 4 Mar 2002 09:49:55 -0500
Date: Mon, 4 Mar 2002 09:54:50 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: Re: [patch] delayed disk block allocation
Message-ID: <20020304145450.GA14256@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not on a big box, but I have a side by side of
2.5.6-pre2 and 2.5.6-pre2 with patches from 
http://www.zipworld.com.au/~akpm/linux/patches/2.5/2.5.6-pre2/

2.5.6-pre2-akpm compiled with MPIO_DEBUG = 0 and ext2 
filesystem mounted with delalloc.

tiobench and dbench were on ext2.
bonnie++ and most other tests were on reiserfs.

2.5.6-pre2-akpm throughput on ext2 is much improved.

http://home.earthlink.net/~rwhron/kernel/akpm.html

One odd number in lmbench is page fault latency.  Lmbench also 
showed high page fault latency in 2.4.18-pre9 with make_request, 
read-latency2, and low-latency.  2.4.19-pre1aa1 with read_latency2 
(2.4.19pre1aa1rl) did not show a bump in page fault latency.   

-- 
Randy Hron

