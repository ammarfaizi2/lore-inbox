Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756508AbWKSIQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508AbWKSIQz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 03:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756510AbWKSIQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 03:16:55 -0500
Received: from mx2.mail.ru ([194.67.23.122]:32799 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1756508AbWKSIQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 03:16:55 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: irda-users@lists.sourceforge.net
Subject: Is ircomm possible with smsc_ircc2?
Date: Sun, 19 Nov 2006 11:16:47 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611191116.47738.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have Toshiba Portege 4000, which apparently needs smsc_ircc2 driver. Driver 
seems to load OK:

Detected unconfigured Toshiba laptop with ALi ISA bridge SMSC IrDA chip, 
pre-configuring device.
Activated ALi 1533 ISA bridge port 0x02e8.
Activated ALi 1533 ISA bridge port 0x02f8.
found SMC SuperIO Chip (devid=0x5a rev=00 base=0x002e): LPC47N227
smsc_superio_flat(): IrDA not enabled
smsc_superio_flat(): fir: 0x2f8, sir: 0x2e8, dma: 03, irq: 7, mode: 0x02
SMsC IrDA Controller found
 IrCC version 2.0, firport 0x2f8, sirport 0x2e8 dma=3, irq=7
No transceiver found. Defaulting to Fast pin select

and it registers irda0 interface but no /dev/ircomm* ever appears. I need them 
(or at least I /think/ I need them) for SynCE (for installing programs in my 
Pocket LOOX).

What is missing? Do I need additional driver? How can I access ircomm on this 
HW?

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFYBLvR6LMutpd94wRAkuOAKC1f7GQ0AeL9xHcJEsMNn0AT9MIOQCglvcL
YEZSnauoxed4K8uPpAMdKtw=
=jU1k
-----END PGP SIGNATURE-----
