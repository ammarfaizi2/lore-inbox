Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268644AbTBZFRV>; Wed, 26 Feb 2003 00:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268645AbTBZFRV>; Wed, 26 Feb 2003 00:17:21 -0500
Received: from quechua.inka.de ([193.197.184.2]:56281 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S268644AbTBZFRT>;
	Wed, 26 Feb 2003 00:17:19 -0500
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Server shipments [was Re: Minutes from Feb 21 LSE Call]
In-Reply-To: <03022522230400.04587@tabby>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.18-xfs (i686))
Message-Id: <E18nu68-0004Ty-00@calista.inka.de>
Date: Wed, 26 Feb 2003 06:27:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <03022522230400.04587@tabby> you wrote:
> Something like a Cray X1, single processor for instance.
> Or a 1024 processor Cray T3, again single system image, even if it doesn't
> have a streaming vector processor.
> 
> I don't see that any of the current cluster systems provide the throughput
> of such a system. Not even IBMs' SP series.

This clearly depends on the workload. For most vector processors
partitioning does not make sense. And dont forget, most of those systems are
pure compute servers used fr scientific computing.

> The output is fed to memory on every clock tick. (most Cray processors have 4 
> memory busses for each processor - two for input data, one for output data 
> and one for the instruction stream

The fastest Cray on top500.org is T3E1200 on rank _22_, the fastest IBM is
ranked _2_ with a Power3 PRocessor. There are 13 IBM systems before the
first (fastest) Cray system. Of course those GFlops are measured for
parallel problems, but there are a lot out there.

And all those numbers are totally uninteresting for DB or Storage Servers.
Even a SAP SD Benchmark would not be fun on a Cray.

> I have used their systems for the last 12 years, and until the Earth Simulator
> came on line, there was nothing that came close to their throughput for 
> weather modeling, finite element analysis, or other large problem types.

thats clearly wrong. http://www.top500.org/lists/lists.php?Y=2002&M=06

There are a lot of Power3 ans Alpha systems before the first cray.

Greetings
Bernd
