Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbSIYAOS>; Tue, 24 Sep 2002 20:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261864AbSIYAOR>; Tue, 24 Sep 2002 20:14:17 -0400
Received: from holomorphy.com ([66.224.33.161]:10653 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261863AbSIYAOR>;
	Tue, 24 Sep 2002 20:14:17 -0400
Date: Tue, 24 Sep 2002 17:18:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
Message-ID: <20020925001826.GM6070@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20020924132031.GJ6070@holomorphy.com> <3D90A532.4B95C06B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D90A532.4B95C06B@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Taken on 32x/32G NUMA-Q:
>> Throughput 67.3949 MB/sec (NB=84.2436 MB/sec  673.949 MBit/sec)  16 procs
>> dbench 16  11.72s user 122.21s system 422% cpu 31.733 total

On Tue, Sep 24, 2002 at 10:47:30AM -0700, Andrew Morton wrote:
> Taken on 2x/0.8G el-scruffo PC:
> Throughput 135.02 MB/sec (NB=168.775 MB/sec  1350.2 MBit/sec)
> ./dbench 16  12.11s user 16.29s system 181% cpu 15.646 total
> What's up with that?

Not sure. This is boot bay SCSI crud, but single-disk FC looks
*worse* for no obvious reason. Multiple disk tests do much better
(about matching the el-scruffo PC numbers above).


Cheers,
Bill
