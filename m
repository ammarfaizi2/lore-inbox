Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261850AbSIYAVP>; Tue, 24 Sep 2002 20:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSIYAVP>; Tue, 24 Sep 2002 20:21:15 -0400
Received: from holomorphy.com ([66.224.33.161]:12445 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261850AbSIYAVP>;
	Tue, 24 Sep 2002 20:21:15 -0400
Date: Tue, 24 Sep 2002 17:25:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
Message-ID: <20020925002529.GE3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20020924132031.GJ6070@holomorphy.com> <3D90A532.4B95C06B@digeo.com> <20020925001826.GM6070@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020925001826.GM6070@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 10:47:30AM -0700, Andrew Morton wrote:
>> Taken on 2x/0.8G el-scruffo PC:
>> Throughput 135.02 MB/sec (NB=168.775 MB/sec  1350.2 MBit/sec)
>> ./dbench 16  12.11s user 16.29s system 181% cpu 15.646 total
>> What's up with that?

On Tue, Sep 24, 2002 at 05:18:26PM -0700, William Lee Irwin III wrote:
> Not sure. This is boot bay SCSI crud, but single-disk FC looks
> *worse* for no obvious reason. Multiple disk tests do much better
> (about matching the el-scruffo PC numbers above).

Exact numbers:

Total throughput: 136.09139999999999 MB/s
dbench.log.j:Throughput 17.4581 MB/sec (NB=21.8226 MB/sec  174.581 MBit/sec)  64 procs
dbench.log.k:Throughput 17.2604 MB/sec (NB=21.5755 MB/sec  172.604 MBit/sec)  64 procs
dbench.log.l:Throughput 19.0192 MB/sec (NB=23.774 MB/sec  190.192 MBit/sec)  64 procs
dbench.log.m:Throughput 15.7826 MB/sec (NB=19.7283 MB/sec  157.826 MBit/sec)  64 procs
dbench.log.n:Throughput 15.8795 MB/sec (NB=19.8494 MB/sec  158.795 MBit/sec)  64 procs
dbench.log.o:Throughput 17.621 MB/sec (NB=22.0263 MB/sec  176.21 MBit/sec)  64 procs
dbench.log.p:Throughput 15.489 MB/sec (NB=19.3613 MB/sec  154.89 MBit/sec)  64 procs
dbench.log.q:Throughput 17.5816 MB/sec (NB=21.977 MB/sec  175.816 MBit/sec)  64 procs

