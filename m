Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135977AbREBVTl>; Wed, 2 May 2001 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135958AbREBVTb>; Wed, 2 May 2001 17:19:31 -0400
Received: from tomts2.bellnexxia.net ([209.226.175.140]:54173 "EHLO
	tomts2-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135977AbREBVT0>; Wed, 2 May 2001 17:19:26 -0400
From: "Patrick Allaire" <patrick.allaire@isaacnewtontech.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: DPT I2O RAID and Linux I2O
Date: Wed, 2 May 2001 17:18:35 -0400
Message-ID: <HEEIIHGBKLFOBPOOOJHCOECCCHAA.patrick.allaire@isaacnewtontech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <E14v41x-0004Mt-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Its a CompactPCI system from Ziatech. We have 2 computers in it. 1 Master
(host) and 1 Slave (local). The master one is a Ziatech 5502 and the slave
is a Ziatech 5541.

The slave computer is isolated from the pci bus with a non-transparent
pci-to-pci bridge : INTEL (DEC) 21554

Basicly I have to transmit data between the host and the local system by the
pci bus.



> -----Message d'origine-----
> De : Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Envoye : May 2, 2001 5:19 PM
> A : Patrick Allaire
> Cc : Alan Cox; linux-kernel@vger.kernel.org
> Objet : Re: DPT I2O RAID and Linux I2O
>
>
> > If I understand correctly, some vendor would put I2O messaging
> hardware but
> > they would use it in a non-standard way ? So, if they dont
> support the I2O
> > protocol with their hardware, I will have to do it in another  way...
> >
> > Is there a simple way to find out if my device support I2O
> protocol ? Maybe
> > its written in the BAR or in the CSR, but does linux find those devices
> > automaticly ? or do I have to do it in my module ? If I must do
> it myself,
> > do you know any device that is doing something like I do ? so I
> could look
> > at the code.
>
> If its running as an I2O device, it will be class I2O PCI and
> it'll have about
> 300K+ of firmware (probably vxworks) loaded onto it and a chunk
> of RAM. WHat
> sort of device is this ?
>
>
>

