Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313907AbSEMOjC>; Mon, 13 May 2002 10:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314043AbSEMOjB>; Mon, 13 May 2002 10:39:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16901 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313907AbSEMOjA>; Mon, 13 May 2002 10:39:00 -0400
Subject: Re: [PATCH] CONFIG_ISA
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Mon, 13 May 2002 15:57:26 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), DiegoCG@teleline.es (Diego Calleja),
        ak@muc.de (Andi Kleen), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1020513163036.26083I-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at May 13, 2002 04:34:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177HGQ-0005ac-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Not neccessarily. The mobility chipset for example has a PS/2 mouse
> > and keyboard port on a PCI card
> 
>  Nice to know.  They can't use motherboard ports, though.
>  So the choice is between a motherboard and a PCI device.  Neither is ISA. 

There are "two user one PC" ISA cards around that put them on ISA addresses
too. That may matter for 2.5 one day but those cards are somewhat old and
uninteresting nowdays (dual 1Mb Cirrus Logic video)

The Mobility is -much- more fun because our current PC keyboard code does
not support hot plugging of the keyboard and ps/2 drivers
