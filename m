Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289013AbSAIUW1>; Wed, 9 Jan 2002 15:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289004AbSAIUWP>; Wed, 9 Jan 2002 15:22:15 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:58523 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S289013AbSAIUWI>; Wed, 9 Jan 2002 15:22:08 -0500
Date: Wed, 9 Jan 2002 21:21:59 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Western Digital 33C296A SCSI support
Message-ID: <20020109202159.GA24136@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
X-Operating-System: vega Linux 2.4.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is there $subject inside eg version 2.4.17 of Linux kernel? I've been told
that this chip was used on boards named 'wd7xxx' inside kernel config.
However after eyeballing the source (drivers/scsi/wd7000.c) it seems that
it's for ISA cards but my card is PCI one:

01:09.0 SCSI storage controller: Western Digital 33C296A
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (1250ns min, 1500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1000 [size=256]
        Region 1: Memory at 40200000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]

Is there any hope to use this scsi adaptor with Linux?

Thanx in advance.

-- 
- Gábor
