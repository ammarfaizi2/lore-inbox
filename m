Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWKBPrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWKBPrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWKBPrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:47:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13216 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751445AbWKBPrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:47:16 -0500
Subject: Re: hdb lost interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manu Abraham <abraham.manu@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <454A0F2B.5060603@gmail.com>
References: <4549B305.7040106@gmail.com>
	 <1162473087.11965.182.camel@localhost.localdomain>
	 <454A0F2B.5060603@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Nov 2006 15:51:21 +0000
Message-Id: <1162482682.11965.202.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-02 am 19:30 +0400, ysgrifennodd Manu Abraham:
> running smartctl -a gave me this ..

Thanks

> [17207074.632000] hdd: command error: status=0x51 { DriveReady
> SeekComplete Error }
> [17207074.632000] hdd: command error: error=0x54 { AbortedCommand
> LastFailedSense=0x05 }

CD stuff so not related.

> [17207531.412000] hdb: dma_intr: status=0x30 { DeviceFault SeekComplete }
> [17207531.412000] ide: failed opcode was: unknown
> [17207531.412000] hda: DMA disabled
> [17207531.412000] hdb: DMA disabled
> [17207534.628000] ide0: reset: success
> [17208781.840000] hdb: drive_cmd: status=0x30 { DeviceFault SeekComplete }
> [17208781.840000] ide: failed opcode was: 0xb0

No idea, it appears the drive got cross and went for a sulk but I've no
idea why and the diagnostics aren't sufficient to tell

