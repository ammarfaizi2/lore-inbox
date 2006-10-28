Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWJ1SIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWJ1SIb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWJ1SIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:08:31 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5028 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751255AbWJ1SIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:08:30 -0400
Subject: Re: AMD X2 unsynced TSC fix?
From: Lee Revell <rlrevell@joe-job.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Andi Kleen <ak@suse.de>, thockin@hockin.org,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <20061028052837.GC1709@1wt.eu>
References: <1161969308.27225.120.camel@mindpipe>
	 <20061027201820.GA8394@dreamland.darkstar.lan>
	 <20061027230458.GA27976@hockin.org> <200610271804.52727.ak@suse.de>
	 <1162006081.27225.257.camel@mindpipe>  <20061028052837.GC1709@1wt.eu>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 14:08:34 -0400
Message-Id: <1162058915.14733.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-10-28 at 07:28 +0200, Willy Tarreau wrote:
> On Fri, Oct 27, 2006 at 11:28:00PM -0400, Lee Revell wrote:
> > On Fri, 2006-10-27 at 18:04 -0700, Andi Kleen wrote:
> > > I don't think it makes too much sense to hack on pure RDTSC when 
> > > gtod is fast enough -- RDTSC will be always icky and hard to use.
> > 
> > I agree FWIW, our application would be happy to just use gtod if it
> > wasn't so slow on these machines.
> 
> Agreed, I had to turn about 20 dual-core servers to single core because
> the only way to get a monotonic gtod made it so slow that it was not
> worth using a dual-core. I initially considered buying one dual-core
> AMD for my own use, but after seeing this, I'm definitely sure I won't
> ever buy one as long as this problem is not fixed, as it causes too
> many problems.

Does anyone know if the problem will really be fixed in new CPUs, as AMD
promised a year or so ago?

http://lkml.org/lkml/2005/11/4/173

Since that post, there has been Socket F and AM2 which apparently have
the same issue.

Were the AMD guys just blowing smoke?

Lee


