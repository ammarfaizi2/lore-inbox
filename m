Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293348AbSCSAgy>; Mon, 18 Mar 2002 19:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293361AbSCSAgo>; Mon, 18 Mar 2002 19:36:44 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:3733 "EHLO
	scaup.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S293348AbSCSAg1>; Mon, 18 Mar 2002 19:36:27 -0500
Date: Mon, 18 Mar 2002 19:41:30 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Message-ID: <20020318194130.A18120@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.6 with Andrew's everything patch on ext2 
filesystem mounted with delalloc came up with
these MB/second on k6-2/475 with IDE disk:

dbench 128	
2.5.6		2.5.6-akpme	akpm % faster
8.4 		12.5 		48

tiobench seq reads (8 - 128 threads avg 3 runs)
2.5.6		2.5.6-akpme	%
9.36 		12.97		38

tiobench seq writes (8 - 128 threads avg 3 runs)
2.5.6		2.5.6-akpme	%
15.3		19.29		26

Both kernels needed reiserfs patches for 2.5.6, but
above tests are on ext2.  

More on these tests and a few other akpm patches at:
http://home.earthlink.net/~rwhron/kernel/akpm.html

-- 
Randy Hron

