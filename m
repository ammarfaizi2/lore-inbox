Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129204AbRBMCuA>; Mon, 12 Feb 2001 21:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129300AbRBMCtu>; Mon, 12 Feb 2001 21:49:50 -0500
Received: from she.sat.on.my.wang.and.it.erupted.net ([64.81.48.109]:63760
	"EHLO ogel.aura.li") by vger.kernel.org with ESMTP
	id <S129204AbRBMCtp>; Mon, 12 Feb 2001 21:49:45 -0500
Date: Mon, 12 Feb 2001 18:49:13 -0800 (PST)
From: xcp <xcp@ogel.aura.li>
To: <linux-kernel@vger.kernel.org>
Subject: /proc/pci and cpuinfo
Message-ID: <Pine.LNX.4.31.0102121844430.7164-100000@ogel.aura.li>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a machine here with a discrepency on the pci information
in /proc/pci:
us  0, device  20, function  0:
    Ethernet controller: 3Com Unknown device (rev 48).
      Vendor id=10b7. Device id=7646.
      Medium devsel.  IRQ 12.  Master Capable.  Latency=32.  Min
Gnt=10.Max Lat=10.
      I/O at 0xe400 [0xe401].
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdf000000].

from lspci:
00:14.0 Ethernet controller: 3Com Corporation 3cSOHO100-TX Hurricane (rev
30)

clearly /proc/pci is wrong!
kernel is 2.2.18 on a P3-450 256mb.

Also, where does Linux detect and document the L2 or L1 cache size on a
socket7 system?  On the pentium3 its in cpuinfo as cache_size, no such
value exists on my P120 system.

Thanks

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
