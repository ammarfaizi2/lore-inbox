Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAFF0C>; Sat, 6 Jan 2001 00:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRAFFZv>; Sat, 6 Jan 2001 00:25:51 -0500
Received: from lineo.ca ([207.245.32.39]:6163 "EHLO mail.lineo.ca")
	by vger.kernel.org with ESMTP id <S129771AbRAFFZh>;
	Sat, 6 Jan 2001 00:25:37 -0500
Date: Sat, 6 Jan 2001 00:25:36 -0500 (EST)
From: "D. Jeff Dionne" <jeff@lineo.ca>
To: linux-kernel@vger.kernel.org
Subject: uClinux 2.4.0.0pre0 released.
Message-ID: <Pine.LNX.4.21.0101060009550.10613-100000@mail.lineo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've put up a patch against linux-2.4.0 for uClinux 2.4.  The supported
platforms are listed below, in the announcement which was sent to the
uClinux-dev list.

We would like to merge into the mainline Linux tree in 2.5, so we've taken
an approach which touches as little as possible of the generic kernel :-) 

Cheers all,
D. Jeff Dionne for the uClinux team.

        This is the release announcement for uClinux-2.4.0.0pre0

uClinux 2.4.0.0pre0 is out.  It is on www.uclinux.org and cvs.uclinux.org
uClinux is a port of the linux kernel to CPUs without MMU.

This relase includes support for Motorola ColdFire MCF5307 and MC68328.
The MCF5307 support targets Lineo NetTEL and the 68328 support targets
XCoPilot.

Status:
  MCF5307 support is the most complete.  It includes networking and drivers
  for the NetTEL.  There are a few memory leaks and there is a bug in
  wait4().

  MC68328 support has been carried forward from test11, and still has a little
  breakage (the interrupt vector table stuff got broken along the way).  We'll
  fix that in the next couple of days.

  Use gcc-2.95.2 configured --target=m68k-elf to build these targets.

Many thanks to David McCullough he did the heavy lifing moving this to release
from my early work on test5, Michael Leslie who did the merge from Randy 
Buchanan's 68328 work.  And of course Linus and the entire community that
produced the Linux 2.4 release.

Go get it!

Cheers,
D. Jeff Dionne


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
