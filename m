Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVB0SC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVB0SC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVB0Rwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:52:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60946 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261442AbVB0Rh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:37:28 -0500
Date: Sun, 27 Feb 2005 18:37:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Build failure of drivers/usb/gadget/ether.c
Message-ID: <20050227173726.GE6148@stusta.de>
References: <200502272021.54173.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502272021.54173.adobriyan@mail.ru>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 08:21:54PM +0200, Alexey Dobriyan wrote:

> FYI, allyesconfig on sparc gives:
> 
>   CC      drivers/usb/gadget/ether.o
> drivers/usb/gadget/ether.c: In function `eth_bind':
> drivers/usb/gadget/ether.c:2418: error: `control_intf' undeclared (first use in this function)
> drivers/usb/gadget/ether.c:2418: error: (Each undeclared identifier is reported only once
> drivers/usb/gadget/ether.c:2418: error: for each function it appears in.)
> make[3]: *** [drivers/usb/gadget/ether.o] Error 1

You didn't mention which kernel version you are using and didn't send 
your .config .

But this looks like an issue already fixed in Greg's tree.
Can you confirm it's fixed in 2.6.11-rc4-mm1?

> 	Alexey

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

