Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbQLOPSa>; Fri, 15 Dec 2000 10:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbQLOPSU>; Fri, 15 Dec 2000 10:18:20 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:44262 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130164AbQLOPSJ>; Fri, 15 Dec 2000 10:18:09 -0500
Message-ID: <3A3A2FD3.88FAA330@uow.edu.au>
Date: Sat, 16 Dec 2000 01:50:59 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Joseph Cheek <joseph@cheek.com>, linux-kernel@vger.kernel.org,
        Donald Becker <becker@scyld.com>
Subject: Re: test12: eth0 trasmit timed out after one hour uptime
In-Reply-To: <3A37FFC9.19F05305@cheek.com>,
		<3A37FFC9.19F05305@cheek.com>; from joseph@cheek.com on Wed, Dec 13, 2000 at 03:01:29PM -0800 <20001215161926.D829@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Wed, Dec 13, 2000 at 03:01:29PM -0800, Joseph Cheek wrote:
> > Dec 13 14:51:46 sanfrancisco kernel: NETDEV WATCHDOG: eth0: transmit
> > timed out
> ...
> I have this too since testX-Kernels are released.
> 
> I use a "3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)"
> (actually two of them ;-)).
> 
> > after reboot it works fine again [i'll give it an hour...]  test12-pre8
> > and before worked fine.  any ideas?
> 
> This seems to be code to debug these timeouts.
> 
> It didn't cause any harm AFICS, but I CC'ed the Author of this
> code anyway.

Ingo,

Donald wrote just about all the Linux netdrivers, but he
now concentrates upon the drivers which he maintains at
http://www.scyld.com.  Other people try to help out with the
drivers which come from kernel.org.

This particular problem does still occur occasionally.

It's way too infrequent to pin down.  It can certainly
be caused by a very high collision rate on a hubbed LAN.
If that were the only cause I would take all the diagnostics
out, because that's simply ethernet.

Other possible causes are lost interrupts in the kernel
or hardware, cabling problems, power supply problems or,
indeed, a driver bug.

If you are able to reproduce this then I'd be very interested
in working with you on it.  First step is to read the final
section of Documentation/networking/vortex.txt, then send
me a long email.

Thanks.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
