Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbSJ2AAR>; Mon, 28 Oct 2002 19:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSJ2AAR>; Mon, 28 Oct 2002 19:00:17 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:30627 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261283AbSJ2AAQ>; Mon, 28 Oct 2002 19:00:16 -0500
Date: Mon, 28 Oct 2002 16:00:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <737410000.1035849619@flay>
In-Reply-To: <200210290049.08582.efocht@ess.nec.de>
References: <200210280132.33624.efocht@ess.nec.de> <200210281838.44556.efocht@ess.nec.de> <536200000.1035826605@flay> <200210290049.08582.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I didn't modify what you sent me at all ... perhaps my machine is
>> just faster than yours?
>> 
>> /me ducks & runs ;-)
> 
> :-)))
> 
> I tried with IA32, too ;-) With PROBLEMSIZE=1000000 I get on a 2.8GHz
> XEON something around 16s. On a 1.6GHz Athlon it's 22s. Both times running
> ./numa_test 2 on a dual CPU box. The usertime is pretty independent of the
> OS, (but the scheduling influences it a lot).

I have 700MHz P3 Xeons, but I have 2Mb L2 cache on them which is much
better than the newer chips. That might make a big differernce.
 
> But: you have a node level cache! Maybe the whole memory is inside that
> one and then things can go really fast. Hmmm, I guess I'll need some
> cache detection in the future to enforce that the BM really runs in
> memory... Increasing PROBLEMSIZE might help, but we can do that later,
> when testing affinity (I'm not giving up on this idea... ;-)

Yup, 32Mb cache. Not sure if it's faster than local memory or not.

M.

