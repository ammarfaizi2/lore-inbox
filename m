Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263596AbRFNSE1>; Thu, 14 Jun 2001 14:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263595AbRFNSES>; Thu, 14 Jun 2001 14:04:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:35085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263574AbRFNSEF>; Thu, 14 Jun 2001 14:04:05 -0400
Subject: Re: Linux-2.4.6-pre3
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 14 Jun 2001 19:02:23 +0100 (BST)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <26832.992400011@ocs4.ocs-net> from "Keith Owens" at Jun 13, 2001 12:40:11 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15AbRo-00053O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 12 Jun 2001 18:42:45 -0700 (PDT), 
> Linus Torvalds <torvalds@transmeta.com> wrote:
> >-pre3:
> > - Jeff Garzik: network driver updates
> 
> tulip_core.c:1756: warning: initialization from incompatible pointer type
> tulip_core.c:1757: warning: initialization from incompatible pointer type

Use pre2. Linus applied a patch that changed the PCI power management stuff
and broke all the drivers. In fact you were lucky you noticed this - it'll
compile with warnings and most users will never realise its totally broken,
or that every third party non kernel 2.4 driver using PM just broke too.


