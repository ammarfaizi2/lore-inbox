Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289020AbSAIVCS>; Wed, 9 Jan 2002 16:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289021AbSAIVCH>; Wed, 9 Jan 2002 16:02:07 -0500
Received: from quark.didntduck.org ([216.43.55.190]:9220 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S289022AbSAIVCD>; Wed, 9 Jan 2002 16:02:03 -0500
Message-ID: <3C3CAE90.E415A2A2@didntduck.org>
Date: Wed, 09 Jan 2002 15:56:48 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: lgb@lgb.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: Western Digital 33C296A SCSI support
In-Reply-To: <20020109202159.GA24136@vega.digitel2002.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gábor Lénárt wrote:
> 
> Hi!
> 
> Is there $subject inside eg version 2.4.17 of Linux kernel? I've been told
> that this chip was used on boards named 'wd7xxx' inside kernel config.
> However after eyeballing the source (drivers/scsi/wd7000.c) it seems that
> it's for ISA cards but my card is PCI one:
> 
> 01:09.0 SCSI storage controller: Western Digital 33C296A
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 66 (1250ns min, 1500ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 11
>         Region 0: I/O ports at 1000 [size=256]
>         Region 1: Memory at 40200000 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
> 
> Is there any hope to use this scsi adaptor with Linux?

WD killed off it's SCSI host adapter division many years ago, and it
took to the grave all the documentation needed for a Linux driver (or
for any other modern OS).  Sorry to say, but you'll need a new card.

--

				Brian Gerst
