Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSECN2h>; Fri, 3 May 2002 09:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSECN2g>; Fri, 3 May 2002 09:28:36 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1545 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311871AbSECN2g>; Fri, 3 May 2002 09:28:36 -0400
Subject: Re: Linux 2.4.19-pre8
To: bunk@fs.tum.de (Adrian Bunk)
Date: Fri, 3 May 2002 14:43:25 +0100 (BST)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.NEB.4.44.0205031239430.2605-100000@mimas.fachschaften.tu-muenchen.de> from "Adrian Bunk" at May 03, 2002 12:42:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173dLJ-0006L4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 8253xdbg.o 8253xplx.o 8253xtty.o 8253xchr.o 8253xint.o amcc5920.o
> 8253xmcs.o 8253xutl.o
> make[4]: *** No rule to make target `8253xcfg.c', needed by `8253xcfg'.
> Stop.
> make[4]: Leaving directory
> `/home/bunk/linux/kernel-2.4/linux/drivers/net/wan/8253x'

Oops. I probably forgot to send Marcelo the makefile tweak

> It seems 8253xcfg.c was accidentially not included.

Remove it from the makefile and it should all be happy

Alan
--
'On the other hand, you sometimes wish the world, like nethack, had some sort
 of "Genocide All Stupid People" key sequence.'  - Alec Muffett
