Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVJaUsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVJaUsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVJaUst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:48:49 -0500
Received: from urchin.mweb.co.za ([196.2.24.26]:1445 "EHLO urchin.mweb.co.za")
	by vger.kernel.org with ESMTP id S1751241AbVJaUst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:48:49 -0500
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: linux-kernel@vger.kernel.org
Subject: BTTV radio seems to stop working
Date: Mon, 31 Oct 2005 22:49:57 +0200
User-Agent: KMail/1.8.92
Cc: video4linux-list@redhat.com, mchehab@brturbo.com.br
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510312249.57970.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I can't seem to listen to radion on my tv card since 2.6.14-rc1. I'm using the 
bttv driver. My card is a FlyVideo98 FM. The modules options that I use are:

options bttv radio=1 card=56 tuner=1


lspci:
00:05.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at 00000000fa015000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>

00:05.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 00000000fa016000 (32-bit, prefetchable) [size=4K]
        Capabilities: <available only to root>
