Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbUCHPNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 10:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbUCHPNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 10:13:19 -0500
Received: from ccs.covici.com ([209.249.181.196]:9179 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id S262506AbUCHPNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 10:13:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16460.36222.191866.759421@ccs.covici.com>
Date: Mon, 8 Mar 2004 10:13:02 -0500
From: John covici <covici@ccs.covici.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
Subject: Re: shuttle an50r Motherboard and Linux
In-Reply-To: <200403080151.28816.bzolnier@elka.pw.edu.pl>
References: <m3wu5w8aex.fsf@ccs.covici.com>
	<200403080151.28816.bzolnier@elka.pw.edu.pl>
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here are the relevant parts of the lspci -v -- I have been using
2.4.22, but if it will make a difference I will try newer ones.

00:00.0 Host bridge: nVidia Corporation nForce3 Host Bridge (rev a4)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device a550
	Flags: bus master, 66Mhz, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [44] #08 [0180]
	Capabilities: [c0] AGP version 3.0

00:01.0 ISA bridge: nVidia Corporation nForce3 LPC Bridge (rev a6)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device a550
	Flags: bus master, 66Mhz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation nForce3 SMBus (rev a4)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device a550
	Flags: 66Mhz, fast devsel, IRQ 5
	I/O ports at 4c00 [size=64]
	I/O ports at 4c40 [size=64]
	Capabilities: [44] Power Management version 2
00:05.0 Ethernet controller: nVidia Corporation nForce3 Ethernet (rev a5)
	Subsystem: Holco Enterprise Co, Ltd/Shuttle Computer: Unknown device a550
	Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 5
	Memory at e8000000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at d000 [size=8]
	Capabilities: [44] Power Management version 2


on Monday 03/08/2004 Bartlomiej Zolnierkiewicz(B.Zolnierkiewicz@elka.pw.edu.pl) wrote
 > 
 > Hi,
 > 
 > On Monday 08 of March 2004 01:11, John Covici wrote:
 > > Hi.  I have had a couple of problems trying to get this Motherboard
 > > to work correctly under Linux.
 > >
 > > The Ethernet 10/100 is supposed to be an RC82540m, but the e100
 > > module does not recognize it.  If you do an lspci it doesn't say
 > > Intel at all, but just Nvidia and Shuttle.  Am I doing something
 > > wrong, or is there a better driver in 2.6 than 2.4 or what?
 > >
 > > Also, I am using the amd74xx driver for the chip set, but it does not
 > > seem to activate dma or announce udma and a number as the via one
 > > does -- is this the correct driver?
 > 
 > What kernel version(s) are you using?
 > What are the boot messages ('dmesg' command output)?
 > What is the output of 'lspci' command?
 > 
 > Regards,
 > Bartlomiej

-- 
         John Covici
         covici@ccs.covici.com
