Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283625AbRK3Ofq>; Fri, 30 Nov 2001 09:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283659AbRK3Ofg>; Fri, 30 Nov 2001 09:35:36 -0500
Received: from cosxlat13.coserv.com ([209.223.12.13]:43282 "EHLO twu.net")
	by vger.kernel.org with ESMTP id <S283625AbRK3OfS>;
	Fri, 30 Nov 2001 09:35:18 -0500
Date: Fri, 30 Nov 2001 08:35:35 -0600 (CST)
From: Jessica Blank <jessica@twu.net>
To: linux-kernel@vger.kernel.org
Subject: Slow start -- Linux vs. NT -- it's time to acknowledge the problem!
Message-ID: <Pine.LNX.4.40.0111300834270.3351-100000@twu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello esteemed kernel hackers:

	As you doubtless know, NT and BSD both have a broken slow-start
implementation. As you may not know, when you try having a Linux box
co-exist on a network with a Windows box, this seems to cause the Windows
box to CROWD OUT the Linux box on the network.

	There is a fix to Solaris for this-- or a "workaround", I should
say:

http://www.sun.com/sun-on-net/performance/tcp.slowstart.html

	THERE IS NO FIX TO LINUX FOR THIS. At least, not as far as I could
find-- and I just got done Web-searching for a solid 15 minutes, finding
MULTIPLE references to the Solaris workaround in the process.

	It is high time this problem is acknowledged and FIXED. I am
forced to share a network with a bunch of NT servers, some of which get
plenty of traffic-- enough so that they manage to crowd out my machine to
the tune of 600ish ms ping times to the Linux box versus only **70**
(!!!!!!) to the Windows box. THESE MACHINES ARE ON THE SAME NETWORK, but
the Linux box is as sluggish, latency-wise, as telnetting into a box on a
MODEM-- whereas the Windows box, where latency isn't even as important (no
one telnets into them), is nice and zippy.

	I do not want to have to move to Solaris.

	Please, how can this problem be solved? PLEASE CC ME ANY
SOLUTION(S) DISCUSSED!

							--Jessica

=========================================
  J e s s i c a    L e a h    B l a n k
-----------------------------------------
  Programmer * Unix Sysadmin * Web Geek
   jessica@jessl.org -- cell@jessl.org
 -`-,-{@  http://www.jessl.org/  @}-,-`-
=========================================



