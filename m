Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316796AbSFDVuJ>; Tue, 4 Jun 2002 17:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSFDVuI>; Tue, 4 Jun 2002 17:50:08 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:36940 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316796AbSFDVuH>; Tue, 4 Jun 2002 17:50:07 -0400
Date: Tue, 4 Jun 2002 16:49:56 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206042149.QAA93039@tomcat.admin.navo.hpc.mil>
To: mhw@wittsend.com, J Sloan <joe@tmsusa.com>
Subject: Re: please kindly get back to me
Cc: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>,
        Larry McVoy <lm@bitmover.com>, Matti Aarnio <matti.aarnio@zmailer.org>,
        "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael H. Warfield" <mhw@wittsend.com>:
...
> 
> 	It's not theoretical and it's not just in the labs.  It's real
> and it's in the wild now.  It just doesn't have the population
> density and the monclonal culture to make it go BANG like the Windows
> worms go.  Yet...
> 
...

So which do you think is better:

1. buy/write/update virus software to catch/trap the virus

2. Fix the security hole.

I put my money on #2.

There are several ways to trap attacks on daemons that have such
vulnerabilities. And using virus scanners CANNOT keep up.

The obvious solution is:

1. Use one of the high security  patches (SELinux or RSBAC) and use
   compartmentalization to keep the problem under control.
2. Use the detected problem to locate and fix the security problem in
   the daemon.

Virus scanners cannot keep up. The virus that does the damage is the one
the scanner doesn't recognize. This is equivalent to the bug that wasn't
fixed.

Generation and propagation of a patch is nearly as fast if not faster
than generating another virus signature; and is a LOT more effective.

The high security patches allow the system to continue functioning even
in the presence of the virus, as long as the virus itself is compartmented.
At one time, there was some discription of the Ramen/lion worm attempting
to attack a SELinux based system.. and failed. It did get in the daemon,
but was then isolated from the rest of the system.

I do believe that the kernel can be improved - not including daemon services
in the kernel itself is one (tux?,nfs?,... yes they work faster, but is it
worth the security risk?).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
