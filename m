Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130163AbQKJRKV>; Fri, 10 Nov 2000 12:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130491AbQKJRKL>; Fri, 10 Nov 2000 12:10:11 -0500
Received: from d06lmsgate.uk.ibm.com ([195.212.29.1]:40115 "EHLO
	d06lmsgate.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S130163AbQKJRKD>; Fri, 10 Nov 2000 12:10:03 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
cc: "Theodore Y. Ts'o" <tytso@MIT.EDU>, Paul Jakma <paulj@itg.ie>,
        Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Message-ID: <80256993.005E3A7E.00@d06mta06.portsmouth.uk.ibm.com>
Date: Fri, 10 Nov 2000 16:08:01 +0000
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> Right.  So what you're saying is that GKHI is adding complexity to the
> kernel to make it easier for peopel to put in non-standard patches which
> exposes non-standard interfaces which will lead to kernels not supported
> by the Linux Kernel Development Community.  Right?

I don't think I mentioned complexity - in what was do you mean adding
complexity? If you mean addition funciton then yes. If you mean kernel
source modificaiton then no. If you mean the mechanism then it's nothing
special - just what a loader does when it fixes up an external reference.

> But if there are no standard hooks in the mainline kernel, it's going to
> be hard to pursuade people that adding the GKHI would be a good thing.
> So for the purposes of getting GKHI into the kernel, argueing for GKHI
> in the abstract is putting the card before the horse.  What I would
> recommend is showing how certain hooks are good things to have in the
> mainline kernel, and to try to pursuade people of that question first.
> Only then try to argue for GKHI.

Quite agree, there are no standard hooks, no hooks at all in fact. I'm
neither seeking to get this accepted or not accepted into the kernel. What
it does do is give me an easier time both as a developer and an installer
when I want to include some rarefied code additions. GKHI was developed
primarily for DProbes.

> P.S.  There are some such RAS features which I wouldn't be surprised
> there being interest in having integrated into the kernel directly
> post-2.4,

Great!

Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
