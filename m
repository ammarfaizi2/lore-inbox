Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbUCGEY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 23:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUCGEY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 23:24:28 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:57825 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261747AbUCGEY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 23:24:26 -0500
Subject: 2.6.3 AGP interrupt not shown in /proc/interrupts? 
To: "kernel mailing list" <linux-kernel@vger.kernel.org>
Message-ID: <opr4g458l34evsfm@smtp.pacific.net.th>
From: "Michael Frank" <mhf@linuxmail.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Sun, 07 Mar 2004 12:23:58 +0800
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P4, running 2.6.3 with APM using sis-agp.

IRQ10 is used by AGP, why is it not listed in /proc/interrupts?

Regards
Michael

             CPU0
    0:     248480          XT-PIC  timer
    1:         13          XT-PIC  i8042
    2:          0          XT-PIC  cascade
    8:          1          XT-PIC  rtc
   11:       1348          XT-PIC  eth0
   12:         58          XT-PIC  i8042
   14:       2246          XT-PIC  ide0
NMI:          0
ERR:          0
C  ide0
NMI:          0
ERR:          0

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] SiS650/651/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
          Subsystem: Micro-Star International Co., Ltd.: Unknown device 5339
          Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
          Interrupt: pin A routed to IRQ 10
          BIST result: 00
          Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
          Region 1: Memory at eb000000 (32-bit, non-prefetchable) [size=128K]
          Region 2: I/O ports at d000 [size=128]
          Capabilities: [40] Power Management version 2
                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
          Capabilities: [50] AGP version 2.0
                  Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2,x4
                  Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 39 10 25 63 03 00 b0 02 00 00 00 03 00 00 00 80
10: 08 00 00 e0 00 00 00 eb 01 d0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 39 53
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 00 00
40: 01 50 02 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 20 00 07 02 00 0f 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
