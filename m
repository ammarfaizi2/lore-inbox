Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132681AbRDID0h>; Sun, 8 Apr 2001 23:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132682AbRDID01>; Sun, 8 Apr 2001 23:26:27 -0400
Received: from QWE4.MATH.CMU.EDU ([128.2.32.156]:63239 "EHLO qwe4.math.cmu.edu")
	by vger.kernel.org with ESMTP id <S132681AbRDID0M>;
	Sun, 8 Apr 2001 23:26:12 -0400
Date: Sun, 8 Apr 2001 23:24:57 -0400 (EDT)
From: Scott A Crosby <crosby@qwes.math.cmu.edu>
X-X-Sender: <crosby@qwe4.math.cmu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: The same Maestro 2E Driver problems (2.2.17)
Message-ID: <Pine.LNX.4.33.0104082323180.19346-100000@qwe4.math.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi... I was going through kernel traffic and read the article on the
Maestro Driver problems.. I'm having very similar problems on my
Dell i5000e laptop.


The symtoms are:

When I play MP3's, on an otherwise unloaded system, I notice progressive
noisiness.. The longer it plays, (5-60 minutes), the stronger these
artifacts are. It's like a constant high-frequency twirping and very
annoying.

When I have xmms 'seek' around, that tends to cause it to start
introducing those artifacts.. If I stop the MP3 player and restart it, the
artifacts go away completely, though they come back again.

A second symptom is that occasionally a channel drops out; either left or
right.

Thse tends to happen on 'song boundries'. IE, times when the sound buffer
is switched before the chip finishes sending it.


Scott



--
Kernel version::
   Linux version 2.2.17 (root@hypercube) (gcc version 2.95.2 20000220
(Debian GNU/Linux)) #20 Mon Sep 25 01:09:51 EDT 2000
--
Maestro Driver feedback and info:

maestro: Configuring ESS Maestro 2E found at IO 0x1400 IRQ 5
maestro:  subvendor id: 0x00cc1028
maestro: PCI power managment capability: 0x7622
maestro: AC97 Codec detected: v: 0x83847609 caps: 0x6940 pwr: 0xf
maestro: 1 channels configured.

--
/proc/pci

  Bus  0, device   8, function  0:
    Multimedia audio controller: Unknown vendor Unknown device (rev 16).
      Vendor id=125d. Device id=1978.
      Medium devsel.  Fast back-to-back capable.  IRQ 5.  Master Capable.
Laten
cy=64.  Min Gnt=2.Max Lat=24.
      I/O at 0x1400 [0x1401].






--
No DVD movie will ever enter the public domain, nor will any CD. The last CD
and the last DVD will have moldered away decades before they leave copyright.
This is not encouraging the creation of knowledge in the public domain.


