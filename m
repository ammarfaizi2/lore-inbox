Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267740AbSLGJzp>; Sat, 7 Dec 2002 04:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267741AbSLGJzp>; Sat, 7 Dec 2002 04:55:45 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:60140 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S267740AbSLGJzo>; Sat, 7 Dec 2002 04:55:44 -0500
Date: Sat, 7 Dec 2002 05:03:27 -0500 (EST)
From: Nathaniel Russell <root@chartermi.net>
X-X-Sender: root@reddog.example.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: reddog83@chartermi.net, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.20] Via 8233 Sound Support
In-Reply-To: <3DF1C53D.8030506@pobox.com>
Message-ID: <Pine.LNX.4.44.0212070501130.1440-100000@reddog.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok i agree with you it turns out my mp3's i always listen to with my
Esoniq card dont wanna play with my Via card.
Well it's ok. So Jeff is my patch for the Via AGP card ok to add to the
Kernel ;) just a wounder.
Nathaniel
CC reddog83@chartermi.net

On Sat, 7 Dec 2002, Jeff Garzik wrote:

> Nathaniel Russell wrote:
> > diff -urN linux-sound/drivers/sound/via82cxxx_audio.c linux/drivers/sound/via82cxxx_audio.c
> > --- linux-sound/drivers/sound/via82cxxx_audio.c	2002-08-02 20:39:44.000000000 -0400
> > +++ linux/drivers/sound/via82cxxx_audio.c	2002-12-07 04:28:04.000000000 -0500
> > @@ -354,6 +353,8 @@
> >  static struct pci_device_id via_pci_tbl[] __initdata = {
> >  	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_5,
> >  	  PCI_ANY_ID, PCI_ANY_ID, },
> > +	{ PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8233_5,
> > +	  PCI_ANY_ID, PCI_ANY_ID, },
> >  	{ 0, }
> >  };
> >  MODULE_DEVICE_TABLE(pci,via_pci_tbl);
>
>
> unfortunately this only works sporadically, and only for some motherboards.
>
> There is a reason why I removed this pci id from the driver, after
> foolishly adding it :)
>

