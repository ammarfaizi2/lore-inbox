Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269851AbSISDZ5>; Wed, 18 Sep 2002 23:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269862AbSISDZ5>; Wed, 18 Sep 2002 23:25:57 -0400
Received: from packet.digeo.com ([12.110.80.53]:34183 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S269851AbSISDZ4>;
	Wed, 18 Sep 2002 23:25:56 -0400
Message-ID: <3D8944EC.D129579D@digeo.com>
Date: Wed, 18 Sep 2002 20:30:52 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
References: <20020918.160057.17194839.davem@redhat.com> <1032393277.24895.8.camel@irongate.swansea.linux.org.uk> <3D89176B.40FFD09B@digeo.com> <20020919021333.GC20500@vitelus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 03:30:52.0837 (UTC) FILETIME=[F4E2F550:01C25F8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> 
> > akpm:/usr/src/cptimer> ./cptimer -d -s
> > nbytes=10240  from_align=0, to_align=0
> >     copy_32: copied 19.1 Mbytes in 0.078 seconds at 243.9 Mbytes/sec
> > __copy_duff: copied 19.1 Mbytes in 0.090 seconds at 211.1 Mbytes/sec
> 
> It's disappointing that this program doesn't seem to support
> benchmarking of MMX copy loops (like the ones in arch/i386/lib/mmx.c).
> Those seem to be the more interesting memcpy functions on modern
> systems.

Well the source is there, and the licensing terms are most reasonable.

But then, the source was there eighteen months ago and nothing happened.
Sigh.

I think in-kernel MMX has fatal drawbacks anyway.  Not sure what
they are - I prefer to pretend that x86 CPUs execute raw C.
