Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbRGBULe>; Mon, 2 Jul 2001 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265425AbRGBULX>; Mon, 2 Jul 2001 16:11:23 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13326 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265424AbRGBULW>; Mon, 2 Jul 2001 16:11:22 -0400
Subject: Re: [RFC] I/O Access Abstractions
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Mon, 2 Jul 2001 21:10:03 +0100 (BST)
Cc: rmk@arm.linux.org.uk (Russell King), alan@lxorguk.ukuu.org.uk (Alan Cox),
        dwmw2@infradead.org (David Woodhouse),
        dhowells@redhat.com (David Howells), jes@sunsite.dk (Jes Sorensen),
        linux-kernel@vger.kernel.org, arjanv@redhat.com
In-Reply-To: <3B40BCDA.CFA5750E@mandrakesoft.com> from "Jeff Garzik" at Jul 02, 2001 02:26:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15HA1D-0006W0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >       You pass a single cookie to the readb code
> > >       Odd platforms decode it
> > 
> > Last time I checked, ioremap didn't work for inb() and outb().
> 
> It should :)

it doesnt need to.

pci_find_device returns the io address and can return a cookie, ditto 
isapnp etc

