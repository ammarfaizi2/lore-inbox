Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSKRTLJ>; Mon, 18 Nov 2002 14:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSKRTLJ>; Mon, 18 Nov 2002 14:11:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4357 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264733AbSKRTLI>;
	Mon, 18 Nov 2002 14:11:08 -0500
Message-ID: <3DD93CD2.10100@pobox.com>
Date: Mon, 18 Nov 2002 14:17:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Morgan <imorgan@webcon.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tco/rng support for Intel chipsets other than the i810?
References: <Pine.LNX.4.44.0211181410000.16963-100000@light.webcon.net>
In-Reply-To: <Pine.LNX.4.44.0211181410000.16963-100000@light.webcon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Morgan wrote:

> On Mon, 18 Nov 2002, Jeff Garzik wrote:
>
>
> >WRT RNG, more than just i810 supports RNG, yes.  There are several
> >chipset ids in i810_rng.c which are for later versions after i810.
> >
> >So, the driver is perhaps misnamed at this point :) but it's not a huge
> >deal, so I haven't renamed it to i8xx_rng.c.  :)
>
>
> Do you think I can just add an entry into the rng_pci_tbl[] for my 845PE
> (8086, 2560) and have it work?


I don't have the docs, so I'm guessing here, but it's entirely possible.

	Jeff



