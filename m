Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131700AbRCTDiH>; Mon, 19 Mar 2001 22:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131705AbRCTDhs>; Mon, 19 Mar 2001 22:37:48 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:64525 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S131700AbRCTDhK>; Mon, 19 Mar 2001 22:37:10 -0500
Message-ID: <3AB6D001.A9655498@vc.cvut.cz>
Date: Tue, 20 Mar 2001 04:35:29 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
Organization: Czech Technical University - Computing and Information Centre
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: cs,cz,en
MIME-Version: 1.0
To: Elmer Joandi <elmer@linking.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: atyfb,matrox hardlocks, multihead, USB broken, 2.4.2-ac8
In-Reply-To: <Pine.LNX.4.30.0103200541050.1535-100000@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elmer Joandi wrote:

> ah - message from matrox framebuffer  - complaining no irq A assigned to
> slot, and  suggesting that BIOS is buggy.

Maybe you disabled it in BIOS? My BIOS has option 'assign irq to vga'...
 
> Will I be more happy when using a dualhead matrox AGP instead of AGP+PCI
> ATI pair ?

It depends on how much heads you need. If you want more than one head
and all heads need full acceleration, do not go to G400/G450. There
is only one accelerator on them... (well, if you are using all displays
together as one big workplace, you can try it; in that case it has
benefit that both heads share same memory, so you can save some
intersection operations).
 
> 2.4.0 kernel, 2.4.2-ac8 USB looks like very very broken.

USB worked for me until about 2.4.2-ac12 (VIA chipset).
							Petr
