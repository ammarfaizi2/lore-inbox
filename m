Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284440AbRLEO55>; Wed, 5 Dec 2001 09:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284436AbRLEO5s>; Wed, 5 Dec 2001 09:57:48 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:47367 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S284440AbRLEO50>;
	Wed, 5 Dec 2001 09:57:26 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15374.13775.921872.835210@abasin.nj.nec.com>
Date: Wed, 5 Dec 2001 09:57:19 -0500 (EST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hints at modifying kswapd params in 2.4.16
In-Reply-To: <E16BMqa-0003V2-00@the-village.bc.nu>
In-Reply-To: <15373.13379.382015.406274@abasin.nj.nec.com>
	<E16BMqa-0003V2-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm not sure if I was understood here.  On both Mandrake 8.0 and Red
Hat 7.1 I'm running the 2.4.16 kernel with the same .confg file, and
built on there respective kernel.  And I'm getting the below different
memory usage patterns with the same processes running.  Seems
something external to the kernel is causing the differences.

As of this morning, December 5th, the Mandrake systems has run longer
then the same kernel ever did on Red Hat.  I say again, with the same
kernel source and same .confg file.

    Sven


Alan Cox writes:
 > > The first system I tried was Red Hat 7.1, it never used more then 2G
 > > of cache memory leaving the other 2G free.
 > > 
 > > The other system, Mandrake 8.0, sucks up all the 4G of memory with
 > > cache but has not yet shown any signs of thrashing.  Though the code
 > > has only been running a few hours.
 > 
 > The RH 7.1 tree is 2.4.2-ac based and certainly wont behave well under some
 > loads.
