Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRKHUJD>; Thu, 8 Nov 2001 15:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277942AbRKHUIx>; Thu, 8 Nov 2001 15:08:53 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:44045 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S278038AbRKHUIh>;
	Thu, 8 Nov 2001 15:08:37 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Frank de Lange <lkml-frank@unternet.org>
Date: Thu, 8 Nov 2001 21:08:10 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <89EA9194B5B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Nov 01 at 17:39, Frank de Lange wrote:
> 
> It seems 2.4.14 and vmware 3.0.x don't like eachother very much on my SMP (yeah
> Abit, yeah yeah I know) box. I've seen several hangs (nothing logged, no
> warning, no nothing) using this combination. The same box, running the same
> vmware but 2.4.13-ac instead does not complain...

Yeah. Use Alan's kernels with VMware. These are one which I daily tests
and for which I can say that they works (== do not use VMware with
2.4.13-ac8, vmmon will not restore correct %cr2 value under some
conditions, use -ac7 until it is clear whether non-standard %cr2 usage 
is going to stay or not).

> Sooooo.... there seems to be something going on there. As vmware loads its own
> kernel modules (licensed under who knows what? The source is available and
> hackable), it could be a bug in those modules. Then again, as it does not occur
> on the -ac series, it could be in the kernel as well. As there's nothing to be
> seen in the logs (it just freezes solid), there's nothing more to report
> currently...

Is it really solid freeze (what does alt-sysrq-s,u,s,b)? 
                                            Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
