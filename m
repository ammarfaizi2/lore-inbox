Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154637-17700>; Sun, 30 Aug 1998 14:40:07 -0400
Received: from bamboo.verinet.com ([204.144.246.3]:14991 "EHLO bamboo.verinet.com" ident: "rdm") by vger.rutgers.edu with ESMTP id <155256-15447>; Sun, 30 Aug 1998 11:50:30 -0400
From: Richard McRoberts <rdm@bamboo.verinet.com>
Message-Id: <199808301747.LAA00714@bamboo.verinet.com>
Subject: Re: Fuzzy hash stuff.. (was Re: 2.1.xxx makes Electric Fence 22x slower)
To: saw@msu.ru, linux-kernel@vger.rutgers.edu
Date: Sun, 30 Aug 1998 11:47:35 -0600 (MDT)
Cc: davem@dm.cobaltmicro.com, sct@redhat.com, torvalds@transmeta.com, mingo@valerie.inf.elte.hu, number6@the-village.bc.nu, haible@ma2s2.mathematik.uni-karlsruhe.de
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu


Andrey V. Savochkin <saw@msu.ru> wrote, 

> I've managed a draft version of the fuzzy hash VMA lookup stuff to work.
> Right now it works only on i386.

> It would be nice to know the speed of ElectricFence programs
> with the patch applied.

> [deletia]

Thanks to Andrey V. Savochkin for his patch for my problem with
Electric Fence that I posted on August 20 for 2.1.xxx.

Though still slower than 2.0.xx, the patch looks like a big
improvement for 2.1.xxx, running my Electric Fence example over
10 times faster.  The patch didn't apply against 2.1.116-2.1.119,
so the new results below are for the patch applied to 2.1.111 (the
only earlier 2.1.xxx that I still have).


Elapsed time in seconds     2.0.34      2.1.117     2.1.111-patched
-----------------------     ------      -------     ---------------

Without Electric Fence       3.82          3.72          3.76

With Electric Fence         14.61        325.85         29.73


The improvement is very much appreciated.

Thanks,

Richard D. McRoberts
Loveland, Colorado USA
rdm@verinet.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
