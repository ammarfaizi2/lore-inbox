Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318743AbSHQVmR>; Sat, 17 Aug 2002 17:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318750AbSHQVmR>; Sat, 17 Aug 2002 17:42:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:51729
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318743AbSHQVmQ>; Sat, 17 Aug 2002 17:42:16 -0400
Date: Sat, 17 Aug 2002 14:36:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
In-Reply-To: <1029611747.4647.3.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10208171435150.23171-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a problem with IOPS assignment and I am still working on how make
each host carry its own fixup.

On 17 Aug 2002, Alan Cox wrote:

>  "On Fri, 2002-08-16 at 18:13, Jean-Luc Coulon wrote:
> > At boot time, I get the messages :
> > 
> > Aug 16 11:34:19 f5ibh kernel: ALI15X3: simplex device: DMA disabled
> > Aug 16 11:34:19 f5ibh kernel: ide0: ALI15X3 Bus-Master DMA disabled
> > (BIOS)
> 
> Linux did the simplex device check. Your ALi controller only permits DMA
> on one of the devices at a time. What is attached to the ALi controller
> ? Also does 2.4.19 base enable DMA correctly ?
> 
> If so then my guess is there is a bug in the changing of the pci setup
> code in 2.4.20pre2-ac3, which shouldnt be hard to figure out
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

