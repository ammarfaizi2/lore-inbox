Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbTGHNa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267300AbTGHNa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:30:59 -0400
Received: from lucidpixels.com ([66.45.37.187]:22442 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S267298AbTGHNa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:30:58 -0400
Date: Tue, 8 Jul 2003 09:45:34 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
Subject: Question regarding Intel 82801EB Audio Chipset Support
Message-ID: <Pine.LNX.4.56.0307080942280.9605@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio Controller

Is this supported?

I've tried:
http://www.cmedia.com.tw/driver/Linux/Ac97/cmaudio-034.tar.gz

Also the kernel option for the Intel 8xx support.

Nothing seems to work however:
war@war:/dev$ cat /dev/dsp
cat: /dev/dsp: No such device
war@war:/dev$

Motherboard: Abit IC7-G

00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev
02)
00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev
02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller
(rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio
Controller

00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio
Controller (rev 02)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 4
        Region 0: I/O ports at d400 [size=256]
        Region 1: I/O ports at d800 [size=64]
        Region 2: Memory at fc102000 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at fc103000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+


