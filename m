Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVCZOfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVCZOfE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 09:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVCZOfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 09:35:04 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:34520 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262107AbVCZOe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 09:34:59 -0500
Date: Sat, 26 Mar 2005 15:35:00 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Linux Serial <linux-serial@vger.kernel.org>
Subject: Re: Garbage on serial console after serial driver loads
Message-ID: <20050326143500.GA5225@dreamland.darkstar.lan>
References: <20050325202414.GA9929@dreamland.darkstar.lan> <20050325203853.C12715@flint.arm.linux.org.uk> <20050325210132.GA11201@dreamland.darkstar.lan> <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Mar 26, 2005 at 11:16:09AM +0100, Jan Engelhardt ha scritto: 
> >Well, serial_core seems to think so:
> >
> >Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
> >ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
> >ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
> >ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
> 
> Does it work if you set the baud rate manually, as a bootloader option?

I'm using console=ttyS0,38400n8. But it also happens with 9600, 57600
and 115200.

Luca
-- 
Home: http://kronoz.cjb.net
Mi piace avere amici rispettabili;
Mi piace essere il peggiore della compagnia.
