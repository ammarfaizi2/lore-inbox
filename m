Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288810AbSAIFPc>; Wed, 9 Jan 2002 00:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288817AbSAIFPW>; Wed, 9 Jan 2002 00:15:22 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:54740 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S288810AbSAIFPQ>; Wed, 9 Jan 2002 00:15:16 -0500
Date: Wed, 9 Jan 2002 00:19:21 -0500
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: Re: 2.4.18pre2aa1
Message-ID: <20020109001921.A11017@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I also couldn't resist to add the dyn_sched because I'm dealing with
> servers that needs to run 2k tasks (with only a few of them running at
> the same time loading cpu), so there the reclaculate loop was evil and
> the change is simple enough to be kind of obviously correct (btw: I also

Something has made a dramatic change in dbench throughput:

2.4.18pre2aa2   Throughput 23.4521 MB/sec (NB=29.3152 MB/sec  234.521 MBit/sec)  64 procs
2.4.17rc2aa2    Throughput 19.6605 MB/sec (NB=24.5756 MB/sec  196.605 MBit/sec)  64 procs
2.4.18pre2      Throughput 12.1986 MB/sec (NB=15.2483 MB/sec  121.986 MBit/sec)  64 procs

2.4.18pre2aa2   Throughput 18.6495 MB/sec (NB=23.3119 MB/sec  186.495 MBit/sec)  128 procs
2.4.17rc2aa2    Throughput 14.1212 MB/sec (NB=17.6515 MB/sec  141.212 MBit/sec)  128 procs
2.4.18pre2      Throughput 8.00551 MB/sec (NB=10.0069 MB/sec  80.0551 MBit/sec)  128 procs

2.4.18pre2aa2   Throughput 9.79641 MB/sec (NB=12.2455 MB/sec  97.9641 MBit/sec)  192 procs
2.4.18pre2      Throughput 8.09211 MB/sec (NB=10.1151 MB/sec  80.9211 MBit/sec)  192 procs
2.4.17rc2aa2    Throughput 5.80232 MB/sec (NB=7.2529 MB/sec   58.0232 MBit/sec)  192 procs

Some more test results for recent kernels are at:
http://home.earthlink.net/~rwhron/kernel/repo.html

> URL:
> 
>   ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre2aa1.bz2

Based on the diff logs, here is a history of changes going into 2.4.18pre2aa1:
http://home.earthlink.net/~rwhron/kernel/2.4.18pre2aa1.html

-- 
Randy Hron

