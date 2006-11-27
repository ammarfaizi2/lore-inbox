Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757290AbWK0IAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757290AbWK0IAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757297AbWK0IAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:00:35 -0500
Received: from n1.cetrtapot.si ([89.212.80.162]:45257 "EHLO n1.cetrtapot.si")
	by vger.kernel.org with ESMTP id S1757290AbWK0IAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:00:35 -0500
Message-ID: <456A9B1C.8060800@cetrtapot.si>
Date: Mon, 27 Nov 2006 09:00:28 +0100
From: "hinko.kocevar@cetrtapot.si" <hinko.kocevar@cetrtapot.si>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: irda-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [irda-users] Is ircomm possible with smsc_ircc2?
References: <200611191116.47738.arvidjaar@mail.ru>
In-Reply-To: <200611191116.47738.arvidjaar@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I have Toshiba Portege 4000, which apparently needs smsc_ircc2 driver. Driver 
> seems to load OK:
> 
> Detected unconfigured Toshiba laptop with ALi ISA bridge SMSC IrDA chip, 
> pre-configuring device.
> Activated ALi 1533 ISA bridge port 0x02e8.
> Activated ALi 1533 ISA bridge port 0x02f8.
> found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
> smsc_superio_flat(): IrDA not enabled
> smsc_superio_flat(): fir: 0x2f8, sir: 0x2e8, dma: 03, irq: 7, mode: 0x02
> SMsC IrDA Controller found
>  IrCC version 2.0, firport 0x2f8, sirport 0x2e8 dma=3, irq=7
> No transceiver found. Defaulting to Fast pin select
> 
> and it registers irda0 interface but no /dev/ircomm* ever appears. I need them 
> (or at least I /think/ I need them) for SynCE (for installing programs in my 
> Pocket LOOX).
> 
> What is missing? Do I need additional driver? How can I access ircomm on this 
> HW?

You probably need to load the ircomm-tty and ircomm modules on top of 
irda stack for /dev/ircomm*.

Best regards,
hinko

-- 
ČETRTA POT, d.o.o., Kranj
Planina 3
4000 Kranj
Slovenija
Tel. +386 (0) 4 280 66 37
E-mail: hinko.kocevar@cetrtapot.si
Http: www.cetrtapot.si

