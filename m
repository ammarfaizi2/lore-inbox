Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290377AbSA3S1V>; Wed, 30 Jan 2002 13:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290319AbSA3S0K>; Wed, 30 Jan 2002 13:26:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8196 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290333AbSA3SYz>; Wed, 30 Jan 2002 13:24:55 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: greg@kroah.com (Greg KH)
Date: Wed, 30 Jan 2002 18:35:15 +0000 (GMT)
Cc: garzik@havoc.gtf.org (Jeff Garzik), alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        viro@math.psu.edu (Alexander Viro),
        phillips@bonn-fries.net (Daniel Phillips), mingo@elte.hu,
        landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <20020130171126.GA26583@kroah.com> from "Greg KH" at Jan 30, 2002 09:11:26 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VzZj-00082y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Especially after spelunking through the SCSI drivers, and being amazed
> that only one of them uses the, now two year old, pci_register_driver()
> interface (which means that only that driver works properly in PCI
> hotplug systems.)

I doubt it does actually. The problem with pci register driver and scsi is
that the two subsystems are designed with violently conflicting goals. Once
DaveJ or someone does the proposed scsi cleanups it'll become the natural
not the obscenely complicated way to do a scsi driver, as well as sorting out
the pcmcia and cardbus scsi mess, and the card failed/recovered stuff once and
for all.

Alan
