Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTAaWsU>; Fri, 31 Jan 2003 17:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262807AbTAaWsU>; Fri, 31 Jan 2003 17:48:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:1260 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262602AbTAaWsT>;
	Fri, 31 Jan 2003 17:48:19 -0500
Message-ID: <3E3AFF5F.89C84069@digeo.com>
Date: Fri, 31 Jan 2003 14:57:35 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OSDL][BENCHMARK] OSDL-DBT-2 - 2.4 vs 2.5 4-way/8-way with vmstat
References: <200301312247.h0VMlxB09932@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2003 22:57:39.0263 (UTC) FILETIME=[275254F0:01C2C97C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White wrote:
> 
> ...
> These loads suck up all the memory they can, so anything that gives us more
> free memory should
> be goodness. We think we are also seeing improvements in 2.5 in free memory,
> but
> we don't know for sure where is best to look and how best to prove it.
> Any advice?

Monitoring /proc/meminfo would be the main means.  Further
info could be obtained by drilling down into /proc/vmstat
and /proc/slabinfo (the latter via bloatmeter, preferably).

http://www.zip.com.au/~akpm/linux/patches/stuff/

Martin Bligh is working on another VM reporting tool `vmtop', which
would be appropriate for that as well.
