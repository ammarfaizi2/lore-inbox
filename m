Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbSLDCGn>; Tue, 3 Dec 2002 21:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbSLDCGn>; Tue, 3 Dec 2002 21:06:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:40652 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266806AbSLDCGn>;
	Tue, 3 Dec 2002 21:06:43 -0500
Message-ID: <3DED64E8.870ECAA5@digeo.com>
Date: Tue, 03 Dec 2002 18:14:00 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com> <20021204000618.GG11730@dualathlon.random> <3DED4CA4.5B9A20EA@digeo.com> <20021204004234.GL11730@dualathlon.random> <3DED5700.C32DC2B0@digeo.com> <20021204012144.GR11730@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2002 02:14:07.0703 (UTC) FILETIME=[D3684670:01C29B3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> > Could be.  Removing -pipe affected it quite a bit.
> 
> you could try decreasing PARENT_PENALTY to 50. I would like to see if
> the scheduler *still* thinks they're interactive stuff then.
> 

That didn't seem to make much difference either way.
