Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263560AbRFAPDZ>; Fri, 1 Jun 2001 11:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263561AbRFAPDQ>; Fri, 1 Jun 2001 11:03:16 -0400
Received: from mail.advanced.org ([209.211.239.10]:29448 "EHLO
	mailhost.advanced.org") by vger.kernel.org with ESMTP
	id <S263560AbRFAPDL>; Fri, 1 Jun 2001 11:03:11 -0400
From: "Terry Katz" <katz@advanced.org>
To: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.[35] + Dell Poweredge 8450 + Oops on boot
Date: Fri, 1 Jun 2001 11:03:10 -0400
Message-ID: <005b01c0eaab$f913b760$21efd3d1@advanced.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <E155prL-0000aH-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0001
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just before I got your suggestion, I tried just that (disabling the PNP
Bios) .. I looked up the trace addresses in the system.map (which I
forgot to include) and saw that it was from the pnp bios) .. It did the
trick :)  I will also see if there's an updated bios available .. 

Thanks!
  Terry

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alan Cox
> Sent: Friday, June 01, 2001 10:25 AM
> To: Terry Katz
> Cc: Linux Kernel
> Subject: Re: 2.4.[35] + Dell Poweredge 8450 + Oops on boot
> 
> 
> > isapnp: Scanning for PnP cards...
> > isapnp: No Plug & Play device found
> > PnP: PNP BIOS installation structure at 0xc00f68f0
> > PnP: PNP BIOS version 1.0, entry at f0000:a611, dseg at 400 
> Unable to 
> > handle kernel paging request at virtual address 0000ff48  printing 
> > eip: 00003c9c *pde = 00000000
> > Oops: 0002
> > CPU:    0
> > EIP:    0068:[<00003c9c>]
> 
> Your Pnp BIOS crahsed somewhere in the BIOS when we called it 
> - Disable PnP bios support or get a bios update
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

