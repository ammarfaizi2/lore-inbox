Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbSKLUwe>; Tue, 12 Nov 2002 15:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266950AbSKLUwe>; Tue, 12 Nov 2002 15:52:34 -0500
Received: from packet.digeo.com ([12.110.80.53]:13715 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266944AbSKLUwe>;
	Tue, 12 Nov 2002 15:52:34 -0500
Message-ID: <3DD16BA5.DFE01C34@digeo.com>
Date: Tue, 12 Nov 2002 12:59:17 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Aaron Lehmann <aaronl@vitelus.com>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
References: <3DD0E037.1FC50147@digeo.com> <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Nov 2002 20:59:17.0570 (UTC) FILETIME=[5D55FA20:01C28A8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> In the area of things I do do every day, the occasionally posted AIM and
> BYTE benchmarks look as though pipe latency and thruput are down, UNIX
> socket latency and thruput are down, and these are things which will make
> the system feel slower.

Yes, the AIM numbers which have been posted here are quite outrageous.
It's (hopefully) either a few Great Big Bugs or something in 2.5 has
invalidated the measurements.  Or, conceivably, the reduction of the
size of the slabs_free list in the slab allocator.

I shall be taking a look at what's going on in there fairly soon.
