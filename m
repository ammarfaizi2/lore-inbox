Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSKKVZ0>; Mon, 11 Nov 2002 16:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbSKKVZ0>; Mon, 11 Nov 2002 16:25:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:36073 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261353AbSKKVZZ>;
	Mon, 11 Nov 2002 16:25:25 -0500
Message-ID: <3DD021D3.B7F1C511@digeo.com>
Date: Mon, 11 Nov 2002 13:32:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alan@cotse.com
CC: linux-kernel@vger.kernel.org, vs@namesys.com
Subject: Re: [BENCHMARK] 2.5.46-mm1 with contest
References: <3DD01B32.4A113A71@digeo.com> <YWxhbg==.563e560fc9743df6e2cd56ac2568e2c0@1037049066.cotse.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 21:32:06.0877 (UTC) FILETIME=[C8B8A0D0:01C289C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Willis wrote:
> 
> > That's an awful lot of mapped memory.  Have you been altering
> > /proc/sys/vm/swappiness?  Has some application run berzerk
> > and used tons of memory?
> >
> > Slab:             7592 kB
> > Committed_AS:   423120 kB
> > PageTables:       1996 kB
> > ReverseMaps:     69425
> > HugePages_Total:    15
> > HugePages_Free:     15
> > Hugepagesize:     4096 kB
> 
> vm.swappiness was set to 0

OK ;)

That sucker really works.  I run my desktop machines (768M and 256M)
at swappiness=80% or 90%.   I end up with 10-20 megs in swap after a
day or two, which seems about right.  The default of 60 is probably a
little too unswappy.

> I'll stick to 2.5.46 for a while yet I guess, to be sure.

Thanks.
