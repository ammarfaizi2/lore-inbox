Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282172AbRK1QWC>; Wed, 28 Nov 2001 11:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283078AbRK1QVw>; Wed, 28 Nov 2001 11:21:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29453 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282161AbRK1QVi>; Wed, 28 Nov 2001 11:21:38 -0500
Subject: Re: PNP Bios
To: jdthood@mail.com (Thomas Hood)
Date: Wed, 28 Nov 2001 16:10:33 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1006962643.11753.2.camel@thanatos> from "Thomas Hood" at Nov 28, 2001 10:50:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1697I9-0005IQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The pnpbios driver the -ac kernels had a driver registration
> interface.  Is that the only or the best way for drivers to
> use the PnP BIOS?  Given that a lot of drivers already use

Its longer term hopefully how all driver interfaces barring the 
real legacy ISA crud will work. We need to make them all look as
similar as possible.

> However we decide to make pnpbios services available to
> drivers, we have smp and hotplug issues to sort out too.

Yep - thats why the docking thread is there. Now we can make it
useful.

> PnP BIOS configures our machines.  Mark the driver
> "experimental" if you like, but please put it in.

Submit it to Linus. I'd agree
