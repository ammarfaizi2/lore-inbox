Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135829AbRECRsD>; Thu, 3 May 2001 13:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135830AbRECRrx>; Thu, 3 May 2001 13:47:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7176 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135829AbRECRrk>; Thu, 3 May 2001 13:47:40 -0400
Subject: Re: Possible PCI subsystem bug in 2.4
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 3 May 2001 18:51:01 +0100 (BST)
Cc: beamz_owl@yahoo.com (Edward Spidre),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0105031004410.30346-100000@penguin.transmeta.com> from "Linus Torvalds" at May 03, 2001 10:08:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vNFo-0005uM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> at ALL. Which means that Linux thinks that it is free... And Linux will
> place PCI devices there. Even though there certainly is memory there.

Ahah.. that explains the Dell inspiron 8000 cardbus + 256Mb bug as well.

> I'll have to work around the BIOS bug some way. Will you be willing to
> try out patches?

Obvious one is to go to the next power of two clear. 

Semi related question: To do I2O properly I need to grab PCI bus space and
'loan' it to the controller when I configure it. Im wondering what the
preferred approach there is.

Alan

