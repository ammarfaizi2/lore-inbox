Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbSKIEIg>; Fri, 8 Nov 2002 23:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSKIEIg>; Fri, 8 Nov 2002 23:08:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:47778 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264723AbSKIEIf>;
	Fri, 8 Nov 2002 23:08:35 -0500
Message-ID: <3DCC8BCB.F5E39AB7@digeo.com>
Date: Fri, 08 Nov 2002 20:15:07 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: Jens Axboe <axboe@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
References: <200211091300.32127.conman@kolivas.net> <3DCC74B0.47A462A9@digeo.com> <200211091426.54403.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Nov 2002 04:15:11.0219 (UTC) FILETIME=[98791C30:01C287A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> >Con Kolivas wrote:
> >> io_load:
> >> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> >> 2.4.18 [3]              474.1   15      36      10      6.64
> >> 2.4.19 [3]              492.6   14      38      10      6.90
> >> 2.4.19-ck9 [2]          140.6   49      5       5       1.97
> >> 2.4.20-rc1 [2]          1142.2  6       90      10      16.00
> >> 2.4.20-rc1aa1 [1]       1132.5  6       90      10      15.86
> >
> >2.4.20-pre3 included some elevator changes.  I assume they are the
> >cause of this.  Those changes have propagated into Alan's and Andrea's
> >kernels.   Hence they have significantly impacted the responsiveness
> >of all mainstream 2.4 kernels under heavy writes.
> >
> >(The -ck patch includes rmap14b which includes the read-latency2 thing)
> 
> Thanks for the explanation. I should have said this was ck with compressed
> caching; not rmap.
> 

hrm.  In that case I'll shut up with the speculating.

You're showing a big shift in behaviour between 2.4.19 and 2.4.20-rc1.
Maybe it doesn't translate to worsened interactivity.  Needs more
testing and anaysis.
