Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTLGCpw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 21:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbTLGCpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 21:45:50 -0500
Received: from ca1.symonds.net ([66.92.42.136]:24449 "EHLO symonds.net")
	by vger.kernel.org with ESMTP id S265291AbTLGCpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 21:45:41 -0500
Date: Sat, 6 Dec 2003 18:36:50 -0800
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 hard lock, 100% reproducible.
Message-ID: <20031207023650.GA772@symonds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Mark Symonds <mark@symonds.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I've got a machine here that is locking hard under
2.4.23.  Normally would suspect it's a hardware problem
but it runs fine on 2.4.22 and also 2.2 series kernels.  
In a bit of a quandry here since that box has shell
users... 

I'm getting no oopses on the monitor nor in the logs -
this is a hard, instantaneous crash.  No kbd, no nothing,
good night. 

I've got a kernel compiling right now with hacking
support, but none of the additional hacking  options
are enabled. 

Wondering if anyone else has seen this?  lspci output is
below, will wait until requested before dumping a bunch
of crap about my hardware onto the list. 

Anything I can do from userland, let me know. 

-- 
Mark 



----------------------- 
symonds:~# lspci
00:00.0 Host bridge: Intel Corp. 82810 GMCH [Graphics
Memory Controller Hub] (rev 03)
00:01.0 VGA compatible controller: Intel Corp. 82810 CGC
[Chipset Graphics Controller] (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev
02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC)
(rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
01:09.0 Multimedia audio controller: Cirrus Logic
Crystal CS4281 PCI Audio (rev 01)
01:0b.0 Ethernet controller: D-Link System Inc RTL8139
Ethernet (rev 10)
01:0d.0 Ethernet controller: VIA Technologies, Inc.
VT86C100A [Rhine 10/100] (rev 06)
01:0e.0 Ethernet controller: Lite-On Communications Inc
LNE100TX (rev 20)
symonds:~#
