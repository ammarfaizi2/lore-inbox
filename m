Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSKSKaT>; Tue, 19 Nov 2002 05:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSKSKaT>; Tue, 19 Nov 2002 05:30:19 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:58075 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264889AbSKSKaS> convert rfc822-to-8bit; Tue, 19 Nov 2002 05:30:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: e100 2.1.6 driver from Intel including into the kernel tree 2.2.22
Date: Tue, 19 Nov 2002 11:37:25 +0100
User-Agent: KMail/1.4.3
References: <200211182320.15546.m.c.p@gmx.net>
In-Reply-To: <200211182320.15546.m.c.p@gmx.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211191137.13027.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 November 2002 23:22, Marc-Christian Petersen wrote:

Hi all again,

> e100_phy.o(.modinfo+0x0): multiple definition of `__module_kernel_version'
> e100_main.o(.modinfo+0x0): first defined here
> e100_test.o(.modinfo+0x0): multiple definition of `__module_kernel_version'
> e100_main.o(.modinfo+0x0): first defined here
> make[3]: *** [e100.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.2.22/drivers/net/e100'
> make[2]: *** [_modinsubdir_e100] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.2.22/drivers/net'
> make[1]: *** [_modsubdir_net] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.2.22/drivers'
> make: *** [_mod_drivers] Error 2
Ok, I've fixed this for now. Module works.

> Static compile succeed but the linker does not link it to the kernel image.
But I am still stuck with this problem. Does any1 have a hint for me?

Alan, maybe you? I think you have the 2.2 experience I need here :-)

ciao, Marc


