Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSCRR06>; Mon, 18 Mar 2002 12:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSCRR0k>; Mon, 18 Mar 2002 12:26:40 -0500
Received: from penguin.linuxhardware.org ([63.173.68.170]:15560 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id <S290796AbSCRR0g>; Mon, 18 Mar 2002 12:26:36 -0500
Date: Mon, 18 Mar 2002 12:13:10 -0500 (EST)
From: Kristopher Kersey <augustus@linuxhardware.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Subject: Re: Kernel Panics on IDE Initialization
In-Reply-To: <20020302130353.A24918@ucw.cz>
Message-ID: <Pine.LNX.4.33.0203181211200.30202-100000@penguin.linuxhardware.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to let everyone know that the problem with the HighPoint
controller on the SOYO Dragon has been fixed with the latest 2.4.19 pre
patches.

Thanks,
Kris Kersey
augustus@linuxhardware.org

On Sat, 2 Mar 2002, Vojtech Pavlik wrote:

> On Fri, Mar 01, 2002 at 08:56:59PM +0000, Alan Cox wrote:
> > > I have word that it's the HighPoint controller's fault.  I will verify
> > > this myself and let you know.
> >
> > Ok
>
> I have many reports the HPT RAID controllers cause kernels (RH 7.3
> install) to crash, unfortunately because the VIA IDE spits an unrelated
> warning message on many of the affected mainboards just before the HPT
> code crashes ...
>
> Well, this patch fixes two possible array overflows in the HPT code.
> There is quite likely a lot more of stuff to fix.
>
> --
> Vojtech Pavlik
> SuSE Labs
>

