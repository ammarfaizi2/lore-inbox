Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbTI2TKY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTI2TKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:10:24 -0400
Received: from pop.gmx.net ([213.165.64.20]:36043 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264506AbTI2TKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:10:20 -0400
X-Authenticated: #13243522
Message-ID: <3F788355.607F0178@gmx.de>
Date: Mon, 29 Sep 2003 21:09:09 +0200
From: Michael Schierl <schierlm@gmx.de>
X-Mailer: Mozilla 4.75 [de]C-CCK-MCD QXW0324v  (Win95; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test4,5,6] [APM] when do you expect to get APM workingagain?
References: <S263203AbTI2MAQ/20030929120016Z+1564@vger.kernel.org> <1064841037.3970.3.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana schrieb:

> It's working fine for me, but I still need to unload some modules before
> trying to suspend. In my case, I must remove the CardBus/PCMCIA modules,
> the sound drivers and UHCI-HCD for my system to suspend and then resume
> properly.

I now removed several things from my test6 kernel:

- CardBus/PCMCIA support
- Networking support
- Mouse support
- Sound support
- Parallel port support
- USB
- AGP
- Framebuffer support and all other graphics support except 
  vga console
- IDE CDROM and floppy disk Support
- ISA bus support
- P'n'P support

and maybe some more things I forgot now

However, no change (except I get lots of errors from services while 
booting) - it freezes after the hard disk is shut down.

Any other ideas?

Michael
