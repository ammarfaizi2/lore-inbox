Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSLaOXP>; Tue, 31 Dec 2002 09:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbSLaOXP>; Tue, 31 Dec 2002 09:23:15 -0500
Received: from [81.2.122.30] ([81.2.122.30]:2054 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S262824AbSLaOXP>;
	Tue, 31 Dec 2002 09:23:15 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212311431.gBVEVLVB001666@darkstar.example.net>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
To: jochen@scram.de (Jochen Friedrich)
Date: Tue, 31 Dec 2002 14:31:21 +0000 (GMT)
Cc: xavier.bestel@free.fr, andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.44.0212311518570.9962-100000@www2.scram.de> from "Jochen Friedrich" at Dec 31, 2002 03:22:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Are drivers for Alpha, Sparc, or anything else with a pci slot apart
> > from an X86 machine available?
> 
> Unfortunately, that wouldn't be enought. There are lots of PCI graphics
> cards available, which still only work in an X86 (and in most cases Alpha)
> machines, although there is an open source driver. The reason is that they
> need the initialisation code in their PCI BIOS, which is X86, binary
> code.

Sorry, I didn't really explain what I meant very well.  I realise that
it's not just a case of getting the driver to compile on other
architectures, what I meant was that if the driver is open source then
anybody is free to work on the support for non-X86 boxes.  If it's
closed source, then only the manufacturer can work on it.

> Alpha works around this by using an X86 emulator in their PAL code.

That's interesting, I didn't know that.  How complete is it?  Does it
just emulate a subset of X86 instructions that are enough for 90% of
initialisation code?

John.
