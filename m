Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTLCBZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 20:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264470AbTLCBZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 20:25:10 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6849 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264469AbTLCBZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 20:25:00 -0500
Date: Wed, 3 Dec 2003 02:24:57 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Chris Smith <chris@realcomputerguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make modules_install error 2.4.23-pre7
Message-ID: <20031203012457.GG20739@fs.tum.de>
References: <200310111157.49598.chris@realcomputerguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310111157.49598.chris@realcomputerguy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 11:57:48AM -0400, Chris Smith wrote:

> Can't get past this error when doing a make_modules with 2.4.23-pre7:
> 
> cd /lib/modules/2.4.23-pre7; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.23-pre7; fi
> depmod: *** Unresolved symbols in       											
> /lib/modules/2.4.23-pre7/kernel/drivers/usb/usbnet.o
> depmod:         generic_mii_ioctl_Rc7a0a077

Looking at 2.4.23-final, this should be fixed now.

Could you confirm that it's fixed?

If not, please send your .config .

> Chris

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

