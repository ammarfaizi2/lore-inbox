Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264838AbSLQIt3>; Tue, 17 Dec 2002 03:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSLQIt3>; Tue, 17 Dec 2002 03:49:29 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53263
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264838AbSLQIt2>; Tue, 17 Dec 2002 03:49:28 -0500
Date: Tue, 17 Dec 2002 00:55:30 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: edward.kuns@rockwellfirstpoint.com
cc: linux-kernel@vger.kernel.org
Subject: Re: i845PE chipset and 20276 Promise Controller boot failure with
 2.4.20-ac2
In-Reply-To: <OF4D4BDDD2.8FD534AB-ON86256C91.007B9286-86256C91.007EE995@rockwellfirstpoint.com>
Message-ID: <Pine.LNX.4.10.10212170054420.31876-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02) (prog-if 8a
[Master SecP PriP])
      Subsystem: Giga-byte Technology: Unknown device 24c2
      Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
      Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
      Latency: 0
      Interrupt: pin A routed to IRQ 9
      Region 0: I/O ports at 01f0
      Region 1: I/O ports at 03f4
      Region 2: I/O ports at 0170
      Region 3: I/O ports at 0374
      Region 4: I/O ports at cc00 [size=16]
      Region 5: Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

What needs to happen now that Intel has BAR5 is to switch the capablities
to MMIO away from bars 0-4!



Andre Hedrick
LAD Storage Consulting Group

