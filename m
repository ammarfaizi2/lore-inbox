Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUFFIeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUFFIeu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 04:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUFFIet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 04:34:49 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:34659 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263089AbUFFIef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 04:34:35 -0400
Date: Sun, 6 Jun 2004 01:40:25 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040606014025.1bc75433.pj@sgi.com>
In-Reply-To: <20040605082647.GQ21007@holomorphy.com>
References: <20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
	<16576.16748.771295.988065@alkaid.it.uu.se>
	<20040604090314.56d64f4d.pj@sgi.com>
	<20040604165601.GC21007@holomorphy.com>
	<20040604170542.576b4243.pj@sgi.com>
	<20040605013139.GM21007@holomorphy.com>
	<20040605010444.6a384e6c.pj@sgi.com>
	<20040605082647.GQ21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> or whatever someone can be arsed to consider a better idea.

If anyone lurking feels the urge to drive this puppy home, jump in.

I'm unavailable, and from what I can guess reading between William's
lines, he's not signed up either.  Be forewarned - it's an area that can
generate some long lkml threads ;).  Both William and I seem to have an
ample supply of keystrokes.


> a user ABI change in a stable series, would be unfriendly

I agree.  While I contemplated such, I don't recall advocating such,
for the reason you state.  We're stuck at least for now with the
sched_(set/get)affinity ABI.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
