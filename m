Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283467AbRLDUkm>; Tue, 4 Dec 2001 15:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283376AbRLDUjV>; Tue, 4 Dec 2001 15:39:21 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:60678 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S283439AbRLDUie>;
	Tue, 4 Dec 2001 15:38:34 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15373.13379.382015.406274@abasin.nj.nec.com>
Date: Tue, 4 Dec 2001 15:38:27 -0500 (EST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sven@research.nj.nec.com (Sven Heinicke), linux-kernel@vger.kernel.org
Subject: Re: hints at modifying kswapd params in 2.4.16
In-Reply-To: <E16BM0B-0003JC-00@the-village.bc.nu>
In-Reply-To: <15373.2398.495306.503255@abasin.nj.nec.com>
	<E16BM0B-0003JC-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have actually moved our code to another Dell 4400 we got at the
same time (in theory the same exact same system) and I rebuilt the
kernel with the same .config file and I am getting different memory
usage patterns.

The first system I tried was Red Hat 7.1, it never used more then 2G
of cache memory leaving the other 2G free.

The other system, Mandrake 8.0, sucks up all the 4G of memory with
cache but has not yet shown any signs of thrashing.  Though the code
has only been running a few hours.

Could this be a C compiler issue?

Alan Cox writes:
 > > Does the AC kernel still have the old VM?  I really wanna stick the
 > > the new stuff but but a need a stable system.  Older kernels 2.4.8 had
 > > highmem issues, not the 2.4.16 has kswap issues.
 > 
 > There's a riel vm patch for 2.4.16 if you want to see if the vm thing is
 > the problem case
 > 
 > Alan
