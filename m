Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSGCTQd>; Wed, 3 Jul 2002 15:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSGCTQc>; Wed, 3 Jul 2002 15:16:32 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:33544
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317215AbSGCTQb>; Wed, 3 Jul 2002 15:16:31 -0400
Date: Wed, 3 Jul 2002 12:17:31 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Dave Jones <davej@suse.de>
cc: Nick Evgeniev <nick@octet.spb.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: linnux 2.4.19-rc1 i845e ide not detected. dma doesn't work
In-Reply-To: <20020703172832.A8934@suse.de>
Message-ID: <Pine.LNX.4.10.10207031216420.18712-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No it has everything to do with determining if the HBA is in compatablity
or native mode and if the device is properly enabled.

On Wed, 3 Jul 2002, Dave Jones wrote:

> On Mon, Jul 01, 2002 at 03:49:43PM +0400, Nick Evgeniev wrote:
> 
>  >     Why are you so assure? It's "msi 845e Max" with LAN on-board mb with
>  > _latest_ BIOS installed....
>  > Just FYI 2.4.18 was even unable to run eepro100 driver on it while intels
>  > e100 driver was working perfectly.
> 
> Could this be related to the pci id clash I pointed out last week?
> That id was for an intel IDE device iirc.
> 
> (Recap: Two id's don't tally between 2.4/2.5)
> 
>         Dave
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

