Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262468AbSIUHx2>; Sat, 21 Sep 2002 03:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262535AbSIUHx2>; Sat, 21 Sep 2002 03:53:28 -0400
Received: from holomorphy.com ([66.224.33.161]:6540 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262468AbSIUHx1>;
	Sat, 21 Sep 2002 03:53:27 -0400
Date: Sat, 21 Sep 2002 00:52:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020921075226.GO3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <20020920080628.GK3530@holomorphy.com> <20020920120358.GV28202@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020920120358.GV28202@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 05:03:58AM -0700, William Lee Irwin III wrote:
> Also notable is that the system time was significantly reduced though
> I didn't log it. Essentially a long period of 100% system time is
> entered after a certain point in the benchmark, during which there are
> few (around 60 or 70) context switches in a second, and the duration
> of this period was shortened.

A radical difference is present in 2.5.37: the long period of 100%
system time is instead a long period of idle time.

I don't have an oprofile vs. 2.5.37 but I'll report back when I do.


Cheers,
Bill
