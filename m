Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSKRVI6>; Mon, 18 Nov 2002 16:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSKRVI6>; Mon, 18 Nov 2002 16:08:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5899 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264836AbSKRVI4>;
	Mon, 18 Nov 2002 16:08:56 -0500
Message-ID: <3DD9588C.8090701@pobox.com>
Date: Mon, 18 Nov 2002 16:15:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vergoz Michael <mvergoz@sysdoor.com>
CC: Ducrot Bruno <poup@poupinou.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain> <20021118170447.GB27595@poup.poupinou.org> <3DD9227E.5030204@pobox.com> <001901c28f2b$2f3540a0$76405b51@romain> <3DD92DE8.7030501@pobox.com> <00c701c28f3d$b044a160$76405b51@romain>
In-Reply-To: <028901c28ead$10dfbd20$76405b51@romain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vergoz Michael wrote:

> >Vergoz Michael wrote:

> >If you are seeing a problem, please describe in detail the problem so
> >that kernel developers may fix it in the current kernel's 8139too.c.
>
>
> * The problem is in packet recv, i'v to work this night to find what 
> exactly
> is the problem


thanks!


>
>
> >>The driver 8139cp.c can be removed to the source entry.
> >
> >
> >This is the preferred driver for the 8139C+ chip, as it included many
> >bug fixes and is much faster than the version from RealTek.
>
>
> * I will make a prupose to all linux kernel developers about that. I 
> prefere
> to fix that problem before to prupose anything else :P



Certainly.  Comments from all are welcome.  Here is the general argument:

8139/A/B/C/D, 8100, 8139 rev K. are all supported by 8139too.

8139C+ is a totally different chip, and thus gets a totally different 
driver.  The realtek 8139C+ changes (which you posted) basically add a 
totally different driver into the same source code.  The only reason for 
this is that PCI ID for 8139C+ is similar [differs on PCI Revision Id].

finally, I emailed my RealTek contact directly, and he said RealTek has 
found no problems with 8139cp.c driver, and they support 8139cp's use.

Regards,

	Jeff





