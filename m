Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbQKIOPV>; Thu, 9 Nov 2000 09:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130286AbQKIOPL>; Thu, 9 Nov 2000 09:15:11 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:25488 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129598AbQKIOO6>;
	Thu, 9 Nov 2000 09:14:58 -0500
Date: Thu, 9 Nov 2000 09:14:26 -0500
Message-Id: <200011091414.JAA21924@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Paul Jakma <paulj@itg.ie>
CC: Michael Rothwell <rothwell@holly-springs.nc.us>,
        Christoph Rohland <cr@sap.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: Paul Jakma's message of Thu, 9 Nov 2000 13:39:04 +0000 (GMT),
	<Pine.LNX.4.21.0011091332080.7475-100000@rossi.itg.ie>
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Thu, 9 Nov 2000 13:39:04 +0000 (GMT)
   From: Paul Jakma <paulj@itg.ie>

   I actually think Linus has been too loose/vague on modules. The
   official COPYING txt file in the tree contains an exception on linking
   to the kernel using syscalls from linus and the GPL. nothing about
   binary modules, and afaik the only statements he's ever made about
   binary modules were off the cuff on l-k a long time (unless someone
   knows a binary module whose vendor can show a written exception from
   Linus et al). 

Actually, he's been quite specific.  It's ok to have binary modules as
long as they conform to the interface defined in /proc/ksyms.  


That being said, the real problem with the GKHI is that as Al said, it
does expose internal kernel interfaces --- and the Linux kernel
development community as a whole refuses to be bound by such interfaces,
sometimes even during a stable kernel series.  

So someone who releases only binary modules will likely be in a world of
hurt.   And that's considered a feature.  Certainly no one is going to
go out of their way to make life easier for binary module authors.

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
