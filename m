Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270714AbTGUVB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270715AbTGUVB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:01:59 -0400
Received: from law11-oe69.law11.hotmail.com ([64.4.16.204]:55300 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270714AbTGUVB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:01:57 -0400
X-Originating-IP: [165.98.111.210]
X-Originating-Email: [bmeneses_beltran@hotmail.com]
From: "Viaris" <bmeneses_beltran@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with kernel 2.5.75 (Urgent)
Date: Mon, 21 Jul 2003 15:16:57 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <Law11-OE69Tet4T2BiK000100b6@hotmail.com>
X-OriginalArrivalTime: 21 Jul 2003 21:16:59.0663 (UTC) FILETIME=[6C13C1F0:01C34FCD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My problem was resuelt (I installed  module inits again), now I can see all
modules loaded, but I have problems, when I want to see my backup, I can't ,
I execute tar tvf /dev/st0 and the follwing message appear:

tar: /dev/st0: Cannot open: No such device
tar: Error is not recoverable: exiting now

I believe that my server not know this device, but I i execute lsmod the
driver of my SCSI card is loaded:

scsi_mod              115892  2 dc395x,ide_scsi

I need to know that others test i can do it.

Thanks, You are very kind.

----- Original Message -----
From: "Viaris" <bmeneses_beltran@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, July 21, 2003 11:25 AM
Subject: Re: Problems with kernel 2.5.75 (Urgent)


> Hi, I compiled version module-init-tools-0.9.12, I installed this in
> /usr/local/sbin and /usr/local/sbin, but I copied manaully (depmod
> generate-modprobe.conf  insmod  insmod.static  modinfo  modprobe  rmmod
> lsmod) in the directory /sbin, compiled again my kernel and copy bzImage
in
> /boot I did the image wuth mkinitrd and copy my System.map in /boot ,mynew
> kernel boot Ok and load my network card, but no load others modules.
>
> Maybe my is that I did copy of files of module-init manaully, how can I do
> it to update automatically?
>
> Thanks,
>
>
>
> ----- Original Message -----
> From: "Luciano Miguel Ferreira Rocha" <luciano@lsd.di.uminho.pt>
> To: "Viaris" <bmeneses_beltran@hotmail.com>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Monday, July 21, 2003 11:06 AM
> Subject: Re: Problems with kernel 2.5.75 (Urgent)
>
>
> >
> > Hi,
> >
> > Module loading has changed in 2.5.x. Do you have module-init-tools
> installed?
> >
> > You may get it at
> http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> >
> > Regards,
> > Luciano Rocha
> >
> > On Mon, Jul 21, 2003 at 10:43:25AM -0600, Viaris wrote:
> > > Hi all,
> > >
> > > I compiled kernel version 2.5.75, before I had kernel 2.4.20, the
> problem is
> > > that I need to enable SCSI DC395x, but when I execute lsmod I not
found
> > > neither modules loaded, only appear:
> > > Module                  Size  Used by
> > >
> > > If I mount manually a module (insmod
> > > /lib/modules/2.5.75/kernel/drivers/scsi/dc395x.ko) the following
message
> > > appear: Error inserting
> > > '/lib/modules/2.5.75/kernel/drivers/scsi/dc395x.ko': -1 Unknown symbol
> in
> > > module, I have my modules.conf in the directory /lib/modules/2.5.75/
but
> > > this kernel no load automatically the modules.
> > >
> > > I need to load this module because Ineed to use the tape backup, I
have
> a
> > > backu that I need urgent.
> > >
> > > How can I do it?
> > >
> > > Thanks,
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
> in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
