Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313529AbSEMN56>; Mon, 13 May 2002 09:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSEMN55>; Mon, 13 May 2002 09:57:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313529AbSEMN54>; Mon, 13 May 2002 09:57:56 -0400
Subject: Re: [PATCH] CONFIG_ISA
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Mon, 13 May 2002 15:16:26 +0100 (BST)
Cc: DiegoCG@teleline.es (Diego Calleja), ak@muc.de (Andi Kleen),
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1020513141909.26083B-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at May 13, 2002 02:23:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177Gcl-0005SV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sorry for my ignorance, but the typical conectors: mouse, keyboard,
> > /dev/ttyS0, /dev/ttyS1, /dev/lp0...aren't isa devices? 
> 
>  The PS/2 mouse and the keyboard (or the 8042, actually) are motherboard
> devices using the 0x00-0xff range of I/O ports -- ISA is above that.

Not neccessarily. The mobility chipset for example has a PS/2 mouse
and keyboard port on a PCI card
