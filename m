Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286815AbSACMK2>; Thu, 3 Jan 2002 07:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286771AbSACMKT>; Thu, 3 Jan 2002 07:10:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57348 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286708AbSACMKH>; Thu, 3 Jan 2002 07:10:07 -0500
Subject: Re: ISA slot detection on PCI systems?
To: esr@thyrsus.com
Date: Thu, 3 Jan 2002 12:20:01 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), davej@suse.de (Dave Jones),
        Lionel.Bouton@free.fr (Lionel Bouton),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020103040301.A6936@thyrsus.com> from "Eric S. Raymond" at Jan 03, 2002 04:03:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16M6qn-00088Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So you're saying the users should be completely lost any time they want
> to use an upated kernel?

Quite honestly if you want a user built "update" kernel it should probably
work out the critical stuff (CPU, memory size limit, SMP) set a few things
to safe values, and build all the driver modules.

Why ask the user at all. The boot process already knows what modules to load
Instead you get

	Checking...
		This is an X86 platform
		You have an AMD K6 processor
		Your machine lacks SMP support
		You have 256Mb of memory

	I am building you a kernel for an AMD K6 series processor with
	up to 1Gb of memory and no SMP. If you add more than 1Gb of memory
	you will need to build a new kernel

Alan
