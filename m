Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSKMQTg>; Wed, 13 Nov 2002 11:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSKMQTg>; Wed, 13 Nov 2002 11:19:36 -0500
Received: from [195.88.78.200] ([195.88.78.200]:20493 "EHLO
	mailout.virtualminds.de") by vger.kernel.org with ESMTP
	id <S261973AbSKMQTf> convert rfc822-to-8bit; Wed, 13 Nov 2002 11:19:35 -0500
From: Nico Meyer <nmeyer@virtualminds.de>
Organization: Virtual Minds AG
To: linux-kernel@vger.kernel.org
Subject: Old Compaq Fibre Channel Adapter
Date: Wed, 13 Nov 2002 17:26:26 +0100
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200211131726.26676.nmeyer@virtualminds.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

we recently bougth a 2-year old Compaq HA/100 Cluster consisting of 2 Proliant
6500/550 Servers and a Fibre Channel U2 Storage (don't have the exact name right now).

I have some trouble getting the FC HBAs to work under Linux. The problem seems
to be that the cpqfc driver is only for the 64Bit adapters, but ours is aparently 32Bit.
It uses a HPFC-500c chip, lspci output ist atached.

Is there any way to get this working (including if necessary modifying the driver myself,
provided I can get all the information I need)?
If you need more informations, please tell me, and I will get them for you.


Thanks in advance for any help.

Nico Meyer

lspci:

00:01.0 Class 0280: 0e11:a0ec (rev 03)
        Subsystem: 0e11:a0ec
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 2000 [size=256]
        Region 1: I/O ports at 2400 [size=256]
        Region 2: Memory at c6af0000 (32-bit, non-prefetchable) [size=512]

