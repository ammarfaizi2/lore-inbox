Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTBDVqe>; Tue, 4 Feb 2003 16:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTBDVqe>; Tue, 4 Feb 2003 16:46:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13975
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267472AbTBDVqb>; Tue, 4 Feb 2003 16:46:31 -0500
Subject: Re: Help with promise sx6000 card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Cuenta de la lista de linux <user_linux@citma.cu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030204213903.A21554@ucw.cz>
References: <20030203221923.M79151@webmail.citma.cu>
	 <20030204213903.A21554@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044399167.29825.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Feb 2003 22:52:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-04 at 20:39, Vojtech Pavlik wrote:
> 1) Make sure the card BIOS is enabled.
> 2) In the BIOS of the card, set it to "Other OS', not Linux

Both should work. "Other OS" changes how the promise cards I have map
the IDE controllers and whether the I2O asks the OS for space or not.
Does your BIOS also change the PCI class or pci idents ?

> 3) Disable support for Promise cards in Linux

Shouldnt be needed now days

> 4) Enable I2O and I2O block devices

Use 2.4.19 or later. The promise stuff freaks if you do clever cache
hints and older kernels don't know about that

> 6) With luck, it'll work. Anyway, SX6000's are DAMN SLOW.

7) Sell the promise card to someone who doesnt know better and buy
a 3ware. Certainly under Linux the 3ware is way faster

> Now to get a SX4000 working, that's a much more interesting task ...

SX4000 is i2o or something stranger ?


