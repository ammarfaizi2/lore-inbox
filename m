Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289855AbSBEXSd>; Tue, 5 Feb 2002 18:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289859AbSBEXSY>; Tue, 5 Feb 2002 18:18:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62481 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289855AbSBEXSQ>; Tue, 5 Feb 2002 18:18:16 -0500
Subject: Re: driverfs support for motherboard devices
To: joelja@darkwing.uoregon.edu (Joel Jaeggli)
Date: Tue, 5 Feb 2002 23:30:01 +0000 (GMT)
Cc: andre@linuxdiskcert.org (Andre Hedrick),
        rmk@arm.linux.org.uk (Russell King), mochel@osdl.org (Patrick Mochel),
        pavel@suse.cz (Pavel Machek),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <Pine.LNX.4.44.0202051505040.15039-100000@twin.uoregon.edu> from "Joel Jaeggli" at Feb 05, 2002 03:06:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16YF2I-0003En-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > What about, say, a Promise PCI IDE card?  You really need to reference
> > > the parent PCI device when the is one.
> > LOL, how about ones that are quad-channel with a DEC-Bridge to slip the
> > local BUSS?
> 
> or an i960rp and 3 promise 20276's, I've got two of those...

Yep. And then you hit the CRIS where the ide appears to be on the CPU 8)

I don't think anyone should be trying to define where the IDE goes in the
heirarchy like this - its dependant on the situation and the platform.

Alan
