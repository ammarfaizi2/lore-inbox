Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSJETsN>; Sat, 5 Oct 2002 15:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSJETsM>; Sat, 5 Oct 2002 15:48:12 -0400
Received: from 62-190-216-136.pdu.pipex.net ([62.190.216.136]:45318 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262492AbSJETsJ>; Sat, 5 Oct 2002 15:48:09 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210052001.g95K1k4t001611@darkstar.example.net>
Subject: Re: 2.5.x and 8250 UART problems
To: Hell.Surfers@cwctv.net
Date: Sat, 5 Oct 2002 21:01:46 +0100 (BST)
Cc: ahu@ds9a.nl, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
In-Reply-To: <01d6006411905a2DTVMAIL4@smtp.cwctv.net> from "Hell.Surfers@cwctv.net" at Oct 05, 2002 08:43:14 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > I've noticed that 8250 UART based serial port performance is poorer in
> > > > 2.5.x than 2.4.x and 2.2.x, on a couple of my machines.
> > > > 
> > > > The 486 SX-20 with 4 MB RAM, running 2.2.21 reliably achieves about 650
> > > > BPS download from another machine, with the port runnnig at 9600 bps. 
> > > > With 2.5.40, many characters are lost at 9600, making, e.g. a ZModem
> > > > transfer retry for almost every block.
> > > 
> > > Have you tried 'hdparm -u'?
> > 
> > Hmmm, I can do, but I thought it was a Bad Thing (tm) for ISA based
> > controllers?  I could be wrong...
> 
> Shouldn't it be fixed, it should work normally anyway.

Not sure, without interupt unmasking, I would expect excessive disk activity to potentially cause data loss, but there isn't excessive disk activity going on anyway.

If you look at:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0207.3/0373.html

though, you'll see why I was asking for clarification before trying 'hdparm -u', because the laptop in question has a broken floppy drive, so if I corrupt the root filesystem, I've got to take it apart, and put the hard disk in another machine to re-install.  Not a five minute job, by any means!

John.
