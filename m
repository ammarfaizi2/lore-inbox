Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273983AbSITAJR>; Thu, 19 Sep 2002 20:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274010AbSITAJR>; Thu, 19 Sep 2002 20:09:17 -0400
Received: from holomorphy.com ([66.224.33.161]:3717 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S273983AbSITAJR>;
	Thu, 19 Sep 2002 20:09:17 -0400
Date: Thu, 19 Sep 2002 17:08:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920000815.GC3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D8A5FE6.4C5DE189@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
>> Looks like fastwalk might not behave so well
>> on this 32 cpu numa system...

On Thu, Sep 19, 2002 at 04:38:14PM -0700, Andrew Morton wrote:
> I've rather lost the plot.  Have any of the dcache speedup
> patches been merged into 2.5?

As far as the dcache goes, I'll stick to observing and reporting.
I'll rerun with dcache patches applied, though.


On Thu, Sep 19, 2002 at 04:38:14PM -0700, Andrew Morton wrote:
> It would be interesting to know the context switch rate
> during this test, and to see what things look like with HZ=100.

The context switch rate was 60 or 70 cs/sec. during the steady
state of the test, and around 10K cs/sec for ramp-up and ramp-down.

I've already prepared a kernel with a lowered HZ, but stopped briefly to
debug a calibrate_delay() oops and chat with folks around the workplace.


Thanks,
Bill
