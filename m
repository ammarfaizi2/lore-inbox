Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTJPKo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTJPKo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:44:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29940 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262817AbTJPKoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:44:54 -0400
Date: Thu, 16 Oct 2003 12:44:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031016104445.GW17986@fs.tum.de>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:59:26PM +0100, James Simmons wrote:
> 
> Here is the latest fbdev patches. Please test!!! Many new enhancements. 
> Several fixes. The patch is against 2.6.0-test7
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>...

When reaming entries in pci_ids.h you should check whether there are 
other users.

The following compile error was caused by your patch:

<--  snip  -->

...
  CC      drivers/char/agp/ati-agp.o
drivers/char/agp/ati-agp.c:421: error: `PCI_DEVICE_ID_ATI_RS300_100' 
undeclared here (not in a function)
...
make[3]: *** [drivers/char/agp/ati-agp.o] Error 1

<--  snip  ->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

