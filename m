Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263593AbSITUYh>; Fri, 20 Sep 2002 16:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263594AbSITUYh>; Fri, 20 Sep 2002 16:24:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24482 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263593AbSITUYg>;
	Fri, 20 Sep 2002 16:24:36 -0400
Date: Fri, 20 Sep 2002 13:32:54 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
cc: Hanna Linder <hannal@us.ibm.com>
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <69960000.1032553974@w-hlinder>
In-Reply-To: <61200000.1032547873@w-hlinder>
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <20020920080628.GK3530@holomorphy.com> <20020920120358.GV28202@holomorphy.com> <61200000.1032547873@w-hlinder>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, September 20, 2002 11:51:13 -0700 Hanna Linder <hannal@us.ibm.com> wrote:

> 
> 	Perhaps it is time to reconsider replacing fastwalk with dcache_rcu. 

These patches were written by Maneesh Soni. Since the Read-Copy Update
infrastructure has not been accepted into the mainline kernel yet (although
there were murmurings of it being acceptable) you will need to apply
those first. Here they are, apply in this order. Too big to post
inline text though. These are provided against 2.5.36-mm1.


http://prdownloads.sourceforge.net/lse/rcu_ltimer-2.5.36-mm1

http://prdownloads.sourceforge.net/lse/read_barrier_depends-2.5.36-mm1

http://prdownloads.sourceforge.net/lse/dcache_rcu-12-2.5.36-mm1

There has been quite a bit of testing done on this and it has proven
quite stable. If anyone wants to do any additional testing that would
be great.

Thanks.

Hanna

