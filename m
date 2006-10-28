Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751838AbWJ1Fee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWJ1Fee (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 01:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWJ1Fee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 01:34:34 -0400
Received: from 1wt.eu ([62.212.114.60]:10756 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751838AbWJ1Fee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 01:34:34 -0400
Date: Sat, 28 Oct 2006 07:28:38 +0200
From: Willy Tarreau <w@1wt.eu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andi Kleen <ak@suse.de>, thockin@hockin.org,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061028052837.GC1709@1wt.eu>
References: <1161969308.27225.120.camel@mindpipe> <20061027201820.GA8394@dreamland.darkstar.lan> <20061027230458.GA27976@hockin.org> <200610271804.52727.ak@suse.de> <1162006081.27225.257.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162006081.27225.257.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 11:28:00PM -0400, Lee Revell wrote:
> On Fri, 2006-10-27 at 18:04 -0700, Andi Kleen wrote:
> > I don't think it makes too much sense to hack on pure RDTSC when 
> > gtod is fast enough -- RDTSC will be always icky and hard to use.
> 
> I agree FWIW, our application would be happy to just use gtod if it
> wasn't so slow on these machines.

Agreed, I had to turn about 20 dual-core servers to single core because
the only way to get a monotonic gtod made it so slow that it was not
worth using a dual-core. I initially considered buying one dual-core
AMD for my own use, but after seeing this, I'm definitely sure I won't
ever buy one as long as this problem is not fixed, as it causes too
many problems.

Willy

