Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263245AbRFENF4>; Tue, 5 Jun 2001 09:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbRFENFq>; Tue, 5 Jun 2001 09:05:46 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:16402 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S263245AbRFENFm>; Tue, 5 Jun 2001 09:05:42 -0400
Date: Tue, 5 Jun 2001 13:50:48 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: johan.adolfsson@axis.com
cc: Oleg Drokin <green@linuxhacker.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: USB requiring PCI
In-Reply-To: <005c01c0ecf6$4343ca40$a1b270d5@homeip.net>
Message-ID: <Pine.LNX.3.96.1010605134927.9033A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2001 johan.adolfsson@axis.com wrote:
> I don't know the details of the implementation, but the CRIS port
> (ETRAX 100LX) has support for USB but no PCI.

A builtin non-PCI USB-host controller, that is. And the driver is in the
kernel so we do support it as well :) 

/BW

> > > AC> o       Make USB require PCI                            (me)
> > > Huh?!
> > > How about people from StrongArm sa11x0 port, who have USB host
> controller (in
> > > sa1111 companion chip) but do not have PCI?
> >
> > The strongarm doesnt have a USB master but a slave.
> >
> > > Probably there are more such embedded architectures with USB
> controllers,
> > > but not PCI bus.
> >
> > Currently we don't support any of them.
> >
> > > How about ISA USB host controllers?
> >
> > They do not exist.

