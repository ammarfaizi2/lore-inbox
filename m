Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271823AbTHMMgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271832AbTHMMgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:36:18 -0400
Received: from post.tau.ac.il ([132.66.16.11]:24723 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S271823AbTHMMgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:36:06 -0400
Subject: Re: Realtek network card
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813133059.616f0faa.skraw@ithnet.com>
References: <20030813133059.616f0faa.skraw@ithnet.com>
Content-Type: text/plain
Message-Id: <1060778227.3098.0.camel@litshi.luna.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 13 Aug 2003 15:37:08 +0300
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.13; VAE: 6.21.0.0; VDF: 6.21.0.12; host: vexira.tau.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-13 at 14:30, Stephan von Krawczynski wrote:
> Hello all,
> 
> does anybody know how to make the below work (neiter 2.2.25 nor 2.4.21 seem to recognise it):
> 

Try modprobe 8139too
(if you are using a precompiled kernel you should have the driver its
quite standard, otherwise make sure that you are building it).

> lspci --vv:
> 
> 00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.: Unknown device 8131 (rev 10)
> 	Subsystem: Realtek Semiconductor Co., Ltd.: Unknown device 8139
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 min, 64 max, 32 set
> 	Interrupt: pin A routed to IRQ 11
> 	Region 0: I/O ports at e800
> 	Region 1: Memory at ee000000 (32-bit, non-prefetchable)
> 	Capabilities: [50] Power Management version 2
> 		Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 
> Regards,
> Stephan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Micha Feigin
michf@math.tau.ac.il

