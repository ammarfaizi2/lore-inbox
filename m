Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSEXEoc>; Fri, 24 May 2002 00:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317084AbSEXEob>; Fri, 24 May 2002 00:44:31 -0400
Received: from vitelus.com ([64.81.243.207]:29458 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S317081AbSEXEob>;
	Fri, 24 May 2002 00:44:31 -0400
Date: Thu, 23 May 2002 21:44:28 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org, jani@astechnix.ro
Subject: Failure report with tridentfb, CyberBlade Ai1
Message-ID: <20020524044428.GA16123@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a laptop with a CyberBlade Ai1 chipset, and I decided to try
the tridentfb because XFree86 4.1.0 does not support this video device
decently.

Unfortunately, the fb driver doesn't do much better. I compiled it
into the kernel, and the kernel started loading under text mode, but
once the framebuffer driver loaded the screen's image turned into a
scrambled picture of the boot screen. I could type blindly to log in
and reboot, but the garbage on the screen was completely constant.

If you'd like more information or access to the machine, please let me
know :). I really want to have a decent video driver on the system.

(utterly OT question because I'm too lazy to make two posts: is anyone
working on agpgart support for the SiS 5591/5592 AGP chipset?)



Tridentfb VERSION 0.6.9, as distributed in 2.4.19-pre8-ac5.

01:00.0 VGA compatible controller: Trident Microsystems: Unknown device 8620 (rev 5d) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 8
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ff000000 (32-bit, non-prefetchable) [size=8M]
        Region 1: Memory at fefe0000 (32-bit, non-prefetchable) [size=128K]
        Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

