Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSFQRbM>; Mon, 17 Jun 2002 13:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316889AbSFQRbL>; Mon, 17 Jun 2002 13:31:11 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13732 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316886AbSFQRbL>;
	Mon, 17 Jun 2002 13:31:11 -0400
Date: Mon, 17 Jun 2002 10:08:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] acpi problems in 2.5.20 or 2.5.21
Message-ID: <20020617100818.A93@toy.ucw.cz>
References: <200206151139.EAA01867@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200206151139.EAA01867@adam.yggdrasil.com>; from adam@yggdrasil.com on Sat, Jun 15, 2002 at 04:39:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>         Linux-2.5.19 with acpi runs fine on every machine that I
> have tried it on, as does Linux-2.5.21 without acpi.  However,
> Linux-2.5.21 with acpi hangs at boot time before the kernel
> prints any output on one of these computers, and reboots at boot
> time before printing any output that I could see on another.
> I suspect that something is wrong with the way the kernel gets

Can you try that "CONFIG_ACPI_BOOT" patch, then setting it to n?

That's what I had to do...
								Pavel

>                                         2.5.19  2.5.21  2.5.21
>                                         + ACPI  + ACPI  no ACPI
> 
> VIA VT82C691 [Apollo PRO] (rev c4)	ok	ok	ok
> VIA VT82C691 [Apollo PRO] (rev 44)	ok	hangs	ok
> Intel 440GX - 82443GX Host bridge	ok	reboots	ok
> 
> 	There were substantial acpi changes in 2.5.20, and
> almost acpi changes in 2.5.21.
> 
> 	Anyhow, I hope this information is useful.
> 
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Milpitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
> 
> _______________________________________________________________
> 
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas - http://devcon.sprintpcs.com/adp/index.cfm?source=osdntextlink
> 
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

