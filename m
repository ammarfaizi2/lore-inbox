Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263342AbSKRSH6>; Mon, 18 Nov 2002 13:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSKRSH6>; Mon, 18 Nov 2002 13:07:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27155 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263342AbSKRSHD>;
	Mon, 18 Nov 2002 13:07:03 -0500
Message-ID: <3DD92DE8.7030501@pobox.com>
Date: Mon, 18 Nov 2002 13:14:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vergoz Michael <mvergoz@sysdoor.com>
CC: Ducrot Bruno <poup@poupinou.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too.c patch for kernel 2.4.19
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain> <20021118170447.GB27595@poup.poupinou.org> <3DD9227E.5030204@pobox.com> <001901c28f2b$2f3540a0$76405b51@romain>
In-Reply-To: <028901c28ead$10dfbd20$76405b51@romain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vergoz Michael wrote:

> Hi list,
>
> The driver that i have post support realtek 8139A/B/C/D/C+ (already 
> tested)
> and another dlink card (realtek based).
> On certain motherboard where the chip is integred you will perhaps 
> have some
> troubles.


Would you be willing to work with Linux kernel developers to integrate 
the useful changes in this driver into the kernel?

The driver you posted is my driver, version 0.9.15, which is an older 
version of the kernel's driver and doesn't include many changes made 
since then.

If you are seeing a problem, please describe in detail the problem so 
that kernel developers may fix it in the current kernel's 8139too.c.

> The driver 8139cp.c can be removed to the source entry.


This is the preferred driver for the 8139C+ chip, as it included many 
bug fixes and is much faster than the version from RealTek.

	Jeff



