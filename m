Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131122AbRCGRtr>; Wed, 7 Mar 2001 12:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131125AbRCGRth>; Wed, 7 Mar 2001 12:49:37 -0500
Received: from balu.sch.bme.hu ([152.66.224.40]:38542 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S131122AbRCGRta>;
	Wed, 7 Mar 2001 12:49:30 -0500
Date: Wed, 7 Mar 2001 18:48:53 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: James Stevenson <mistral@stev.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tts/0: 1 input overrun(s)
In-Reply-To: <200103062355.f26NtGs01356@stev.org>
Message-ID: <Pine.GSO.4.30.0103071847250.6179-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Mar 2001, James Stevenson wrote:
> with the serial port it has a buffer when it recives data the
> serial port buffer will fill up if data is not read quickly enough
> the buffer will overflow hence the 1 input overrun
>
> to fix it your could try to reduce the data rate to the serial port
> and what type of UART do you have in that port ?

I don't think this should be normal.
The relevant dmesg part:
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A

I am using 115200.

Balazs Pozsar.

> >Hi all,
> >
> >I get the following message:
> > tts/0: 1 input overrun(s)
> >
> >each time while downloading pictures from my digital camera via ttyS0,
> >_and_ switching between an X session and textmode console.
> >(ie, 1 switch -> 1 error)
> >
> >This is with 2.4.1. I don't remember getting these with 2.2
> >This error also means a transmit error (gphoto reports error and a packet
> >has to be retransferred.)
> >
> >What is this? Why I'm getting it? What should I do? :)
> >
> >bye,
> >Balazs Pozsar.
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>
>

