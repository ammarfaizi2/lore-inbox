Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291291AbSBXVCr>; Sun, 24 Feb 2002 16:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291251AbSBXVCh>; Sun, 24 Feb 2002 16:02:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6152 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291254AbSBXVCa>; Sun, 24 Feb 2002 16:02:30 -0500
Subject: Re: Flash Back -- kernel 2.1.111
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Sun, 24 Feb 2002 21:15:06 +0000 (GMT)
Cc: hozer@drgw.net (Troy Benjegerdes), torvalds@transmeta.com (Linus Torvalds),
        andre@linuxdiskcert.org (Andre Hedrick),
        riel@conectiva.com.br (Rik van Riel),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3C794DC0.7040706@evision-ventures.com> from "Martin Dalecki" at Feb 24, 2002 09:32:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16f5z8-0002id-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The previous code didn't distinguish the bus speed between different
> busses and it doesn't do now as well.
> It could be really helpfull to look at the patch actually. Don't you
> think?

I know what would actually help here, (the other code wasn't broken IMHO)
and would clean this up properly for not just IDE. Add a bus_speed field
to the struct pci_bus - that is where the info belongs and its the platform
specific bus code that can find the bus speed out (if anyone)

Alan
