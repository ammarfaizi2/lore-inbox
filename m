Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293053AbSCJOcU>; Sun, 10 Mar 2002 09:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293055AbSCJOcK>; Sun, 10 Mar 2002 09:32:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2319 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293053AbSCJOby>; Sun, 10 Mar 2002 09:31:54 -0500
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
To: tomlins@cam.org (Ed Tomlinson)
Date: Sun, 10 Mar 2002 14:47:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, hanky@promise.com.tw (Hank Yang),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20020310142341.56FE11204@oscar.casa.dyndns.org> from "Ed Tomlinson" at Mar 10, 2002 09:23:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16k4be-0006dG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Second.  There seems to be problems with the ide reset code in pre2-ac2. 
> I get the following:
> 
> hde: timeout waiting for DMA
> PDC202XX: Primary channel reset.
> hde: ide_dma_timeout: Lets do it again!stat = 0x50, dma_stat = 0x20
> hde: DMA disabled
> PDC202XX: Primary channel reset.
> hde: ide_set_handler: handler not null; old=c018eeb0, new=c0193de4
> bug: kernel timer added twice at c018ed31.
> hde: dma_intr: status=0xd0 { Busy }
> hde: DMA disabled

Yep. You turned on some of the experimental stuff. It doesnt always recover
Hopefully the patches from Promise will help there
