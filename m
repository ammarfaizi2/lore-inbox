Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283612AbRK3NST>; Fri, 30 Nov 2001 08:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283652AbRK3NSK>; Fri, 30 Nov 2001 08:18:10 -0500
Received: from TK212017087078.teleweb.at ([212.17.87.78]:30450 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S283651AbRK3NSB>;
	Fri, 30 Nov 2001 08:18:01 -0500
Date: Fri, 30 Nov 2001 14:16:16 +0100
From: Armin Obersteiner <armin@xos.net>
To: Greg KH <greg@kroah.com>
Cc: Armin Obersteiner <armin@xos.net>, linux-kernel@vger.kernel.org
Subject: Re: usb slow in >2.4.10
Message-ID: <20011130141616.B25328@elch.elche>
In-Reply-To: <20011130040719.A21515@elch.elche> <20011129202959.B8633@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129202959.B8633@kroah.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

sorry, with no error messages i totally forgot:

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 06) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at cc00 [size=32]

i beleive thats on the VT82C686 chip, isn't it?

Nov 24 12:52:21 elch kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Nov 24 12:52:21 elch kernel: uhci.c: USB UHCI at I/O 0xd000, IRQ 9
Nov 24 12:52:21 elch kernel: uhci.c: detected 2 ports

for each of the 2 controllers.

> On Fri, Nov 30, 2001 at 04:07:19AM +0100, Armin Obersteiner wrote:
> > hi!
> > 
> > all my usb devices work, but they are very slow (12 times slower) with kernels
> > 2.4.14 and higher. it definetly was ok with 2.4.10.
> 
> Which USB Host controller driver are you using?
> 
> thanks,
> 
> greg k-h

MfG,
	Armin Obersteiner
--
armin@xos.net                        pgp public key on request        CU
