Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVLLUSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVLLUSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVLLUSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:18:33 -0500
Received: from [62.38.104.168] ([62.38.104.168]:40652 "EHLO pfn3.pefnos")
	by vger.kernel.org with ESMTP id S932221AbVLLUSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:18:31 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: kraxel@bytesex.org, lkml <linux-kernel@vger.kernel.org>
Subject: No sound from CX23880 tuner w. 2.6.15-rc5
Date: Mon, 12 Dec 2005 22:17:55 +0200
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512122217.56616.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded from 2.6.13.2 to 2.6.15-rc5 last week. Unfortunately I can no 
longer hear the sound from my tuner (analog tv).
lspci -vv -s 02:05.0
02:05.0 Multimedia video controller: Conexant CX23880/1/2/3 PCI Video and 
Audio Decoder (rev 05)
        Subsystem: LeadTek Research Inc.: Unknown device 663b
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

Is that bug acknowledged? Any early hints before I start a regression test?
Radio (w. gnomeradio) works OK on the card. I can also hear 'peaks' whenever I 
change the tv channel.
