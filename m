Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSHFWjT>; Tue, 6 Aug 2002 18:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSHFWjT>; Tue, 6 Aug 2002 18:39:19 -0400
Received: from mail01.qualys.com ([12.162.2.5]:54405 "HELO mail01.qualys.com")
	by vger.kernel.org with SMTP id <S316217AbSHFWjS>;
	Tue, 6 Aug 2002 18:39:18 -0400
Subject: intel chipsets not recognized in 2.4.19
From: "Walter A. Boring IV" <wboring@qualys.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Aug 2002 15:35:58 -0700
Message-Id: <1028673358.2551.4.camel@hemna.qualys.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy, 
  I just compiled/installed 2.4.19 on my new Dell box.
I can't seem to enable dma on it due to the kernel not detecting the IDE
chipset correctly, as you can see from the lspci dump below.



[root@hemna ide]# lspci
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge (rev 11)
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
(rev 11)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)
00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5
(rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX]
(rev b2)
02:02.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 78)

---<snip>----
00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)
(prog-if 8a [Master SecP PriP])
        Subsystem: Dell Computer Corporation: Unknown device 0132
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at <unassigned> [size=8]
        Region 1: I/O ports at <unassigned> [size=4]
        Region 2: I/O ports at <unassigned> [size=8]
        Region 3: I/O ports at <unassigned> [size=4]
        Region 4: I/O ports at ffa0 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable)
[disabled] [size=1K]
---<snip>----


I saw several posts related to this on the archives for the mailing
list, but it doesn't seem to work on my box.
 Any ideas how to hack around this so I can get dma running?

Thanks
Walt
wboring@qualys.com

p.s. please respond to my email addy



