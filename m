Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135964AbREBVMl>; Wed, 2 May 2001 17:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135977AbREBVMj>; Wed, 2 May 2001 17:12:39 -0400
Received: from tomts2.bellnexxia.net ([209.226.175.140]:65436 "EHLO
	tomts2-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135964AbREBVM1>; Wed, 2 May 2001 17:12:27 -0400
From: "Patrick Allaire" <patrick.allaire@isaacnewtontech.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: DPT I2O RAID and Linux I2O
Date: Wed, 2 May 2001 17:11:35 -0400
Message-ID: <HEEIIHGBKLFOBPOOOJHCIECBCHAA.patrick.allaire@isaacnewtontech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <E14uh2D-0002LG-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I understand correctly, some vendor would put I2O messaging hardware but
they would use it in a non-standard way ? So, if they dont support the I2O
protocol with their hardware, I will have to do it in another  way...

Is there a simple way to find out if my device support I2O protocol ? Maybe
its written in the BAR or in the CSR, but does linux find those devices
automaticly ? or do I have to do it in my module ? If I must do it myself,
do you know any device that is doing something like I do ? so I could look
at the code.

Thank again.



> > Is this I2O implementation supporting PCI devices ?
>
> Yes
>
> > Yesterday I post something about that, I have a CompactPCI
> computer with 2
> > computers in it. One master and one slave. The slave one, is has a non
> > transparent pci-to-pci bridge : DEC (INTEL) 21554, wich support I2O
> > messaging, I want both computer to communicate by this mean,
> but I cant seam
>
> I2O messaging and I2O protocol are two things. Most sane vendors use I2O
> messaging hardware to implement something that looks a little
> more like a device
> control protocol than SNA.
>
> Alan
>
>
>
>

