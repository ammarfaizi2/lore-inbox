Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315481AbSECACH>; Thu, 2 May 2002 20:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSECACF>; Thu, 2 May 2002 20:02:05 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:48135
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315478AbSECABh>; Thu, 2 May 2002 20:01:37 -0400
Date: Thu, 2 May 2002 17:00:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pres and IDE DMA
In-Reply-To: <E173O5B-0004tW-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10205021659010.2107-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry but it did assign then the XP way, otherwise you would not be able
to use the legacy address.

Andre Hedrick
LAD Storage Consulting Group

On Thu, 2 May 2002, Alan Cox wrote:

> >   I'm having issues with a Tyan 2720 and post 2.4.18 boards with a 
> > Maxtor 4G120J6.  Under 2.4.18 I can turn on dma via "hdparm -d 1". 
> >  Under 2.4.19pre7 I get "HDIO_SET_DMA fail ed: Operation not permitted". 
> 
> The BIOS fails to assign the resources
> 
> > PS-There is also some issue with a resource conflict that occurs under 
> > every kernel I've tried.
> 
> Yep. Your BIOS didnt assign them.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

