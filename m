Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbUCLPnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUCLPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:43:44 -0500
Received: from 217-162-71-11.dclient.hispeed.ch ([217.162.71.11]:41864 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S262219AbUCLPnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:43:02 -0500
Message-ID: <4051DA83.90902@steudten.com>
Date: Fri, 12 Mar 2004 16:42:59 +0100
From: Thomas Steudten <alpha@steudten.com>
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Msg from scsi aic7xxx driver or PCI layer on alpha
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: Mailer
X-Check: 2c1783c72b2809387bfafaa1e08e3128
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I got this messages from the pci allocator and the
scsi aic7xxx driver on kernel 2.6.4 on alpha after
reboot: (why is this driver don´t using dma?)

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
         <Adaptec 2940 Ultra SCSI adapter>
         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

[..]
scsi0:A:3:0: Tagged Queuing enabled.  Depth 128
PCI: Enabling device: (0000:00:07.0), cmd 7
XXX PCI: Unable to reserve mem region #2:1000@a051000 for device 0000:00:07.0
aic7xxx: <Adaptec AHA-294X Ultra SCSI host adapter> at PCI 0/7/0
XXX aic7xxx: I/O ports already in use, ignoring.

lspci -vv gives
00:07.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
         Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min, 2000ns max), cache line size 08
         Interrupt: pin A routed to IRQ 26
         Region 0: I/O ports at 8400 [size=256]
         Region 1: Memory at 000000000a051000 (32-bit, non-prefetchable)
[size=4K]
         Expansion ROM at 000000000a040000 [disabled] [size=64K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-



-- 
Tom

LINUX user since kernel 0.99.x 1994.
RPM Alpha packages at http://alpha.steudten.com/packages
Want to know what S.u.S.E 1995 cdrom-set contains?





