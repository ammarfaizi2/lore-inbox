Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267880AbTAKSTE>; Sat, 11 Jan 2003 13:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267891AbTAKSTE>; Sat, 11 Jan 2003 13:19:04 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:61844
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267880AbTAKSTD>; Sat, 11 Jan 2003 13:19:03 -0500
Subject: Re: 2.4.21-pre3 (bk from 20030110): Trident sound (ALi M5451)
	doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301111624.h0BGO9nY003599@eeyore.valparaiso.cl>
References: <200301111624.h0BGO9nY003599@eeyore.valparaiso.cl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042312466.2952.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 11 Jan 2003 19:14:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 16:24, Horst von Brand wrote:
> Trying to modprobe trident by hand gives:
> 
> Jan 11 17:07:56 eeyore kernel: Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h, 15:40:57 Jan 10 2003
> Jan 11 17:07:56 eeyore kernel: PCI: Found IRQ 11 for device 00:06.0
> Jan 11 17:07:56 eeyore kernel: trident: ALi Audio Accelerator found at IO 0x1000, IRQ 11
> Jan 11 17:07:56 eeyore kernel: ALi 5451 did not come out of reset.
> Jan 11 17:07:56 eeyore kernel: trident_ac97_init: error resetting 5451.
> Jan 11 17:07:56 eeyore insmod: /lib/modules/2.4.21-pre3/kernel/drivers/sound/trident.o: init_module: No such device
> Jan 11 17:07:56 eeyore insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg

Should work ok in with the change in pre3-ac

