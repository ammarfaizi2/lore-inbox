Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbTHZU1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbTHZU1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:27:42 -0400
Received: from ns1.citynetwireless.net ([209.218.71.4]:26121 "EHLO
	mail.citynetwireless.net") by vger.kernel.org with ESMTP
	id S262875AbTHZU1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:27:39 -0400
Message-ID: <000501c36c10$c292c120$0500000a@bp>
From: "Ro0tSiEgE LKML" <lkml@ro0tsiege.org>
To: <linux-kernel@vger.kernel.org>
Subject: Missing natsemi PCI ID
Date: Tue, 26 Aug 2003 15:29:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taken from "lspci -vvv".
The computer is an HP Pavilion ze4145 notebook. Most of the devices do not
have corresponding PCI ID's in the kernel, but I am only worried about the
NIC right now.

00:12.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller
             Subsystem: Unknown device 3c08:2400
             Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
             Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
             Interrupt: pin A routed to IRQ 11
             Region 0: I/O ports at 8c00
             Region 1: Memory at e0003000 (32-bit, non-prefetchable)
             Capabilities: [40] Power Management version 2
                          Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                          Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Any help would be greatly appreciated, I've had this notebook for 6 months
and cannot use the network card under Linux. I tested it with Windows and
OpenBSD and the network card works fine under both.

--
Bubba Parker
lkml@ro0tsiege.org




