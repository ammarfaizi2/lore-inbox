Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313289AbSDJQSL>; Wed, 10 Apr 2002 12:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313293AbSDJQSK>; Wed, 10 Apr 2002 12:18:10 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:32782 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S313289AbSDJQSJ>; Wed, 10 Apr 2002 12:18:09 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A776C@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Gabor Kerenyi'" <wom@tateyama.hu>
Cc: linux-kernel@vger.kernel.org
Subject: RE: how to write driver for PCI cards
Date: Wed, 10 Apr 2002 09:18:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabor,

> There is a good news (at least for me), my company would like to 
> have a Linux driver for its card. And this great task is mine. 
> So I'm going to write a driver.

What kind of card is it? serial, SCSI, network? ...

> But I don't know where to start. OK, the interface and how the 
> driver should be written is clear(more or less) but I don't have 
> any documents for it. 

A good place to start is to find and study an existing Linux driver 
for a similar device. 

> Can anyone give me some online docs about PCI bus? (I found some 
> info about PCI-9050 chip but it doesn't contain what I need.)

Did you mean PLX-9050 PCI interface chip? This is a widely used chip
and should have several examples. If your device uses interrupts, you 
will need to know how the kind of interrupt sources (edge, level) and 
how they are connected to the 9050.

A Linux PCI HOW-TO file is at http://www.tldp.org/HOWTO/PCI-HOWTO.html.
General Linux PCI driver info is in /usr/src/linux*/Documentation/pci.txt.
See also /usr/src/linux*/Documentation/devices.txt. That's a start. 

Good luck,
Ed Vance

