Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWJ2B2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWJ2B2v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 21:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWJ2B2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 21:28:51 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:43731 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751453AbWJ2B2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 21:28:50 -0400
Subject: Re: AMD X2 unsynced TSC fix?
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Willy Tarreau <w@1wt.eu>, thockin@hockin.org,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <200610281233.27588.ak@suse.de>
References: <1161969308.27225.120.camel@mindpipe>
	 <200610281137.22451.ak@suse.de> <20061028191515.GA1603@1wt.eu>
	 <200610281233.27588.ak@suse.de>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 21:28:55 -0400
Message-Id: <1162085335.14733.34.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 12:33 -0700, Andi Kleen wrote:
> On Saturday 28 October 2006 12:15, Willy Tarreau wrote:
> 
> > Yes it was, because the small gain of using a dual core with such
> > a workload was clearly lost by that change. IIRC, I reached 25000
> > sessions/s on dual core with TSC if I didn't care about the clock,
> > 20000 without TSC, and 18000 on single core+TSC. But with the sniffer,
> > it was even worse : I had 500 kpps in dual-core+TSC, 70kpps without
> > TSC and 300 kpps with single-core+TSC. Since I had to buy the same
> > machines for both uses, this last argument was enough for me to stick
> > to a single core.
> 
> Ok, but it is a very specialized situation not applicable to most
> others. I just say this for all the other people following the thread.
> Again most workloads are not that gtod intensive.

Haven't benchmarked or anything, but isn't X11 also a very gtod
intensive workload?

Lee

