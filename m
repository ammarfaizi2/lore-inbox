Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266574AbRGYUKr>; Wed, 25 Jul 2001 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267501AbRGYUKh>; Wed, 25 Jul 2001 16:10:37 -0400
Received: from [64.76.58.171] ([64.76.58.171]:32936 "HELO sigma.cioh.org.co")
	by vger.kernel.org with SMTP id <S266574AbRGYUKd>;
	Wed, 25 Jul 2001 16:10:33 -0400
Date: Wed, 25 Jul 2001 15:10:09 -0500 (COT)
From: "TO. Wilderman Ceren" <wceren@cioh.org.co>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with dmfe.o in 2.4.7 (fwd) 
In-Reply-To: <200107251818.f6PIIwHd014527@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.33L2.0107251504040.9437-100000@sigma.cioh.org.co>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Ok., I'm trying the eth1 (Davicom 9102) with tulip module shared with eth0
(Digital).

Errors now printed in the console:

eth1: transmit timed out
eth1: 21140 transmit timed out, status fc740000,
eth1: transmit timed out, switching to 100baseTx
eth1: transmit timed out
eth1: 21140 transmit timed out, status fc740000
eth1: transmit timed out, switching to MII media.
eth1: Out-of-sync dirty pointer, 4611 vs. 4628.
eth1: Setting full-duplex based on MII#1
eth1: transmit timed out
eth1: transmit timed out

On Wed, 25 Jul 2001, Horst von Brand wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> said:
> > On Wed, 25 Jul 2001, TO. Wilderman Ceren wrote:
> > > I have a problem., i compile this morning the kernel 2.4.7, when i
> > > reboot and load the new compiled bzImage, the module is not loaded by
> > > insmod., errors found:
> > >
> > > /lib/modules/2.4.7/kernel/drivers/net/dmfe.o: init_module: No such
> > > device
> > > Hint: insmod errors can be caused by incorrect module parameters,
> > > including invalid IO or IRQ parameters
> > > /lib/modules/2.4.7/kernel/drivers/net/dmfe.o: insmod
> > > /lib/modules/2.4.7/kernel/drivers/net/dmfe.o failed
> > > /lib/modules/2.4.7/kernel/drivers/net/dmfe.o: insmod dmfe failed
> > >
> > [SNIPPED...]
> > In /etc/modules.conf, look at eth0 alias and/or eth1 alias. It
> > should be the name of the driver you intend to use. You don't
> > have to reboot for tests, just put the right stuff in and
> > do your `ifconfig` stuff by hand.
> >
> > Also, sometime, with your new kernel running, do `depmod -a` this
> > will update the dependencies.
>
> Here on RH 7.1 we are using the tulip module for dmfe. Works fine AFAIKT.
>

-- 

-*-*-*-*-*-*-*-*-*-*-
Wilderman Ceren
Tecnologo en Sistemas
Este Mensaje fue enviado desde Pine
ICQ: 4493959 - 37207794
MSN Messenger: wildercol

