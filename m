Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVFLEka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVFLEka (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 00:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVFLEk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 00:40:29 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:38349 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261871AbVFLEj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 00:39:59 -0400
Date: Sat, 11 Jun 2005 23:43:20 -0500
From: Wes Newell <w.newell@verizon.net>
Subject: Pata support for SIS180
To: "linux.kernel" <linux-kernel@vger.kernel.org>
Message-id: <42ABBD68.1040802@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't get any replies in linux-ide so I'll try here.

Can anyone tell me if/how one could add device support for the sis180 
chipset pata ports to the sis5513 module? I've tried adding this as 
others have said it works for the 965 southbridge,

if ((trueid == 0x5518) || (trueid == 0x0180)) {

but it stll doesn't see a real sis180 on a Jetway S755MAX MB.

Here's the device info.

00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS] RAID bus 
controller 180 SATA/PATA  [SiS] (prog-if 85)
       Subsystem: Silicon Integrated Systems [SiS] RAID bus controller 
180 SATA/PATA  [SiS]
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
       Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
       Latency: 128
       Interrupt: pin A routed to IRQ 19
       Region 0: I/O ports at dc00 [size=8]
       Region 1: I/O ports at e000 [size=4]
       Region 2: I/O ports at e400 [size=8]
       Region 3: I/O ports at e800 [size=4]
       Region 4: I/O ports at ec00 [size=16]
       Region 5: I/O ports at <unassigned>
       Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS] RAID bus 
controller 180 SATA/PATA  [SiS]
00: 39 10 80 01 07 04 20 02 00 85 04 01 00 80 00 00
10: 01 dc 00 00 01 e0 00 00 01 e4 00 00 01 e8 00 00
20: 01 ec 00 00 01 00 00 00 00 00 00 00 39 10 80 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 56 23 06 04 56 23 06 04 00 00 00 00 00 00 00 00
50: 82 20 82 00 2a 96 00 03 00 00 00 00 00 00 00 00
60: ff aa 00 00 d9 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: bd 33 72 40 bd 33 72 40 00 00 00 00 00 00 00 00
90: 34 00 00 03 6f 05 00 00 cc 04 0c 10 c0 05 c0 05
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 01 00 18 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 01 00 18 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


-- 
Abit KT7-Raid (KT133) Tbred B core CPU @2400MHz (24x100FSB)
My server http://wesnewell.no-ip.com/cpu.php
Verizon server http://mysite.verizon.net/res0exft/cpu.htm

