Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318153AbSIAXAp>; Sun, 1 Sep 2002 19:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318158AbSIAXAp>; Sun, 1 Sep 2002 19:00:45 -0400
Received: from web14002.mail.yahoo.com ([216.136.175.93]:10903 "HELO
	web14002.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318153AbSIAXAo>; Sun, 1 Sep 2002 19:00:44 -0400
Message-ID: <20020901230513.68661.qmail@web14002.mail.yahoo.com>
Date: Sun, 1 Sep 2002 16:05:13 -0700 (PDT)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: Re: Linux 2.4.20-pre5-ac1
To: linux-kernel@vger.kernel.org
In-Reply-To: <1030753981.1249.5.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Its on the list of deep weirdnesses but fairly low down right now
> 
I gave up on that for now ;) 

I received a couple of  emails from others who had problems
with the 845G which I did not have.

So, I put together another machine with a spare Intel 845GBVL 
motherboard, which also has the 845G chipset.
IDE and DMA seem to work when running 2420pre5ac1, but
no DMA in 2420pre5.

Now on the other hand the Gigabyte (845G chipset) works with
2420pre5 (DMA, ide-scsi) but no success with 2420pre5ac1.

In looking at the lspci's of both boards, I noticed a difference. I
put excerpts
below along with links to full dmesg/lspci.

Bizarre and wierdness sums it up. Which is the real 845G?
Which machine do I dropkick? ;)

Tony


****Intel board:
00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)
(prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 5247
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at <unassigned> [size=8]
	Region 1: I/O ports at <unassigned> [size=4]
	Region 2: I/O ports at <unassigned> [size=8]
	Region 3: I/O ports at <unassigned> [size=4]
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 20000000 (32-bit, non-prefetchable) [disabled]
[size=1K]
****Gigabyte board (Award BIOS):
00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)
(prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 24c2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at bc00 [size=8]
	Region 1: I/O ports at c000 [size=4]
	Region 2: I/O ports at c400 [size=8]
	Region 3: I/O ports at c800 [size=4]
	Region 4: I/O ports at cc00 [size=16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

Gigabyte 845 links
http://ac.marywood.edu/tspin/www/dmesg2420pre5gb.txt
http://ac.marywood.edu/tspin/www/dmesg2420pre5ac1gb.txt
http://ac.marywood.edu/tspin/www/lspcigb.txt
Intel 845G links
http://ac.marywood.edu/tspin/www/dmesg2420pre5ac1.txt
http://ac.marywood.edu/tspin/www/dmesg2420pre5.txt
http://ac.marywood.edu/tspin/www/lspci.txt



__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
