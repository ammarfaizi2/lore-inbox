Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVADXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVADXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVADXNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:13:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27318 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262179AbVADXIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:08:23 -0500
Subject: Re: VIA IDE - dma_timer_expiry - 2.4.28
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Moretti <j.moretti@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <14002.1104840287@www3.gmx.net>
References: <14002.1104840287@www3.gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104858818.17166.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 22:04:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 12:04, John Moretti wrote:
> hdc: dma_timer_expiry: dma status == 0x20
> hdc: timeout waiting for DMA
> hdc: timeout waiting for DMA
> hdc: (__ide_dma_test_irq) called while not waiting
> hdc: status timeout: status=0xd0 { Busy }
> hdc: drive not ready for command
> ide1: reset timed-out, status=0xd0
> hdc: status timeout: status=0xd0 { Busy }
> hdc: drive not ready for command
> ide1: reset timed-out, status=0xd0

The drive went for a walk and didn't come back

That could be a whole pile of things (for reference I get 100+ day
uptimes on VIA mini-itx boxes)

1. Overheating
2. Lack of power
3. Some glitch that then triggers the kernel error recovery into
upsetting the drive.

If it reboots back happily then all 3 are quite plausible

