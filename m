Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSHZOYU>; Mon, 26 Aug 2002 10:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSHZOYU>; Mon, 26 Aug 2002 10:24:20 -0400
Received: from pD9E2394F.dip.t-dialin.net ([217.226.57.79]:58544 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318113AbSHZOYT>; Mon, 26 Aug 2002 10:24:19 -0400
Date: Mon, 26 Aug 2002 08:28:12 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Colonel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Export symbols corrected...
In-Reply-To: <20020826100023.A900@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208260825080.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 26 Aug 2002, Russell King wrote:
> > -export-objs	:= armksyms.o apm.o dma.o ecard.o fiq.o io.o time.o
> > +export-objs	:= armksyms.o dma.o ecard.o fiq.o io.o time.o
> 
> You're doing it again; maybe you should read back at the comments last
> time you posted a patch on this subject?  apm.c is present in my tree,
> but not yours.

I thought you had it fixed in the meanwhile. There was lots of time to do 
so.

> > -export-objs := generic.o irq.o dma.o sa1111.o
> > +export-objs := generic.o dma.o
> 
> sa1111.o not merged yet (not even with me).  Hands orf.

But irq.o is correct?

> > -export-objs :=	dma.o generic.o irq.o pcipool.o sa1111.o sa1111-pcibuf.o \
> > -		usb_ctl.o usb_recv.o usb_send.o pm.o
> > +export-objs :=	dma.o generic.o pcipool.o sa1111.o sa1111-pcibuf.o pm.o
> 
> The usb stuff has moved into a subdirectory now, so yea.

irq.o correct again, either?

Do you have an idea about when the sa1111 is going to get merged?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

