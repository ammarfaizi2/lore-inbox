Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTIQLmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 07:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbTIQLmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 07:42:17 -0400
Received: from math.ut.ee ([193.40.5.125]:14843 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262731AbTIQLmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 07:42:16 -0400
Date: Wed, 17 Sep 2003 14:42:13 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Qlogic ISP & sparc64 & 2.4
Message-ID: <Pine.GSO.4.44.0309171439020.12513-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to load qlogicisp module on my sparc64 (Ultra 5). modprobe
failed, dmesg shows

qlogicisp : new isp1020 revision ID (2)
qlogicisp : ram checksum failure

Is this a problem with unsupported card or a problem with qlogicisp
driver on sparc64?

>From lspci -vvv:

02:01.0 SCSI storage controller: QLogic Corp. ISP1020 Fast-wide SCSI (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin A routed to IRQ 6672128
        Region 0: I/O ports at 2000500 [size=256]
        Region 1: Memory at 000001ff00010000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [size=64K]


-- 
Meelis Roos (trying BusLogic FlashPoint next :)))

