Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271696AbRHUOYq>; Tue, 21 Aug 2001 10:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271695AbRHUOYg>; Tue, 21 Aug 2001 10:24:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65041 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271694AbRHUOYU>; Tue, 21 Aug 2001 10:24:20 -0400
Subject: Re: 2.4.9 breaks apm, ymfpci, pcmcia on VAIO + patch
To: mm@lunetix.de (Martin Mueller)
Date: Tue, 21 Aug 2001 15:27:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, dahinds@users.sourceforge.net
In-Reply-To: <20010821160628.A2296@cicero.werkleitz.de> from "Martin Mueller" at Aug 21, 2001 04:06:28 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZCV0-0007xr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux 2.4.8 worked _extremely_ well, all problems except the wrong
> battery display gone. I just could suspend the running laptop while

Does 2.4.8-ac8 show the 2.4.9 problem. If so then we can try and binary
search out where it broke

> Aug 21 15:01:32 cicero kernel: PCI: Enabling device 00:09.0 (0000 -> 0003) 
> Aug 21 15:01:32 cicero kernel: PCI: Found IRQ 9 for device 00:09.0 
> Aug 21 15:01:32 cicero kernel: ymfpci: YMF744 at 0xfedf8000 IRQ 9 
> Aug 21 15:01:33 cicero kernel: ymfpci_codec_ready: codec 0 is not ready [0xffff] 
> 
> This is with the ymfpci module shipped with the kernel tree, the
> ALSA messages are roughly the same.

Something failed to bring back the codec ACLink.

