Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269753AbSISCIl>; Wed, 18 Sep 2002 22:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269755AbSISCIl>; Wed, 18 Sep 2002 22:08:41 -0400
Received: from vitelus.com ([64.81.243.207]:16 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S269753AbSISCIk>;
	Wed, 18 Sep 2002 22:08:40 -0400
Date: Wed, 18 Sep 2002 19:13:33 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
Message-ID: <20020919021333.GC20500@vitelus.com>
References: <20020918.160057.17194839.davem@redhat.com> <1032393277.24895.8.camel@irongate.swansea.linux.org.uk> <3D89176B.40FFD09B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D89176B.40FFD09B@digeo.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> akpm:/usr/src/cptimer> ./cptimer -d -s     
> nbytes=10240  from_align=0, to_align=0
>     copy_32: copied 19.1 Mbytes in 0.078 seconds at 243.9 Mbytes/sec
> __copy_duff: copied 19.1 Mbytes in 0.090 seconds at 211.1 Mbytes/sec

It's disappointing that this program doesn't seem to support
benchmarking of MMX copy loops (like the ones in arch/i386/lib/mmx.c).
Those seem to be the more interesting memcpy functions on modern
systems.
