Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317572AbSGEVEJ>; Fri, 5 Jul 2002 17:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317576AbSGEVEI>; Fri, 5 Jul 2002 17:04:08 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28932 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317572AbSGEVEH>; Fri, 5 Jul 2002 17:04:07 -0400
Subject: Re: Cyrix IRQ routing is wrong?
To: wingel@acolyte.hack.org (Christer Weinigel)
Date: Fri, 5 Jul 2002 22:29:52 +0100 (BST)
Cc: robn@verdi.et.tudelft.nl (Rob van Nieuwkerk), linux-kernel@vger.kernel.org
In-Reply-To: <m3sn2y43r1.fsf@acolyte.hack.org> from "Christer Weinigel" at Jul 05, 2002 05:02:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17QaeG-0004Gn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My suggestion is to never ever use the text mode on a Geode platform
> and instead use the VESA framebuffer to seleect a framebuffer mode
> that is directly supported by the hardware.  That way mode, only
> modifications of the resolution or the palette will result in SMI
> interrupts and that code does not seem to be as buggy as the text mode
> emulation.

Also to note - performance in both modes is actually about the same so
you might as well enjoy the penguins. Do check for BIOS updates too
the fact its SMI code and the thing is mostly smoke and mirrors (or
just smoke if the fan fails) does mean bios stuff fixes apparent hardware
problems
