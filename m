Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbSLDCK0>; Tue, 3 Dec 2002 21:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266817AbSLDCKZ>; Tue, 3 Dec 2002 21:10:25 -0500
Received: from fmr02.intel.com ([192.55.52.25]:32717 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266810AbSLDCKZ>; Tue, 3 Dec 2002 21:10:25 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D4001070F20F@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: igor@txc.com, linux-kernel@vger.kernel.org
Subject: RE: performance of cache-intensive applications
Date: Tue, 3 Dec 2002 18:17:52 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This kind of problem could be solved by cache coloring. There should be some
patch available for Linux. I don't know if the other OSes you tried
implement cache coloring, though.

Jun

> -----Original Message-----
> From: Igor Schein [mailto:igor@txc.com]
> Sent: Tuesday, December 03, 2002 6:09 PM
> To: linux-kernel@vger.kernel.org
> Subject: performance of cache-intensive applications
> 
> Hi,
> 
> I am using an open-source application on ix86 to perform a task which
> is cache-intensive.  When I run consecutive iterations of the task on
> a fixed input, the variance in timing of each iteration is extemely
> high.   Needless to say, the test machine is always non-occupied.
> 
> On every other OS I tried, Solaris, HPUX, FreeBSD and Tru64, the
> timing is very consistent between the iterations.  My question is, are
> there known issues with L2 cache reuse in Linux kernel?
> 
> I can provide any necessary information for anyone interested in
> addressing this issue, but I purposely skipped most technical details
> in this post to keep it simple.
> 
> Thanks in advance.
> 
> Igor
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
