Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130781AbQKIOYO>; Thu, 9 Nov 2000 09:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130286AbQKIOYE>; Thu, 9 Nov 2000 09:24:04 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:27024 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S130781AbQKIOXt>;
	Thu, 9 Nov 2000 09:23:49 -0500
Date: Thu, 9 Nov 2000 09:23:42 -0500
Message-Id: <200011091423.JAA21926@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
        Christoph Rohland <cr@sap.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: Michael Rothwell's message of Thu, 09 Nov 2000 08:43:14 -0500,
	<3A0AA9F2.9F76DF1@holly-springs.nc.us>
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Thu, 09 Nov 2000 08:43:14 -0500
   From: Michael Rothwell <rothwell@holly-springs.nc.us>

   And how would a hypothetical Advanced Linux Kernel Project be different?
   Set aside the GKHI and the issue of binary-only hook modules; how would
   an "enterprise" fork be any different than RT or UC? It'll go off,
   change and add some things, and then perhaps be merged back in later. In
   the meantime, developers who want to add "enterpriseness" to Linux will
   have an outlet and won't have to simply gripe on this list anymore. And
   users who want an "enterprise" kernel can get one.

Well, there are three possibilities about how it can end up.

1)  It will be loaded with so much crap that in fact it ends up being
less performant than the mainline Linux.  No problem, we can ignore it.

2)  It will be a thing of perfect beauty, in which every single change
is thoughtfully well-considered, and scales well to both the low end and
the high end.  No problem, it's easy to merge stuff back.

3) It will be a mixture, of some stuff which is good, and some such
which is crap, and it will be very difficult hard to merge back some of
the good stuff, since it has dependencies on the crap.  In the meantime,
mainline Linux will have continued moving forward, and it will be even
harder to merge the advanced features of Linux back into the forked
version of the kernel.


One of the big reasons why many of the big companies have been looking
at Linux is because Unix OS engineering is viewed as a cost center, not
as a profit center.  The moment you fork and make an "Advanced Linux
Kernel Project", a lot of the costs involved with maintaining such a
beast come back.  And sure, you can try to solve this problem by working
in a consoritum-like fashion with other Companies ---- just like OSF/1
and Monterrey tried to do.  

So there are some real costs associated with forking.  At the same time,
if these companies need to get product out the door quickly, short-term
forks can be good things.  But nothing in life is free, and it's in
*everybody's* best interest to resolve forks as soon as possible.
Otherwise, you end up losing a lot of the advantages of the Open Source
development model.

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
