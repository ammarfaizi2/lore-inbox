Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbTJZXnW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 18:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbTJZXnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 18:43:22 -0500
Received: from tomteboda.mdh.se ([130.243.76.141]:24255 "EHLO tomteboda.mdh.se")
	by vger.kernel.org with ESMTP id S262991AbTJZXnU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 18:43:20 -0500
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] R8169 on 2.6.0-test9
Date: Mon, 27 Oct 2003 00:43:13 +0100
Message-ID: <066301c39c1a$ed75d0f0$034d210a@sandos>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The r8169 gigabit ethernet card causes lockups on both 2.4.22 and
2.6.0-test9.

It does it even on 2.4.20 and using the 8139cp. Heres lspci -vvv, starting
to wonder if this card is special/odd/unsupported or if its just this
hardware not being happy.

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 (rev
10)
        Subsystem: CNet Technology Inc ProG-2000L
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

---
John Bäckstrand

