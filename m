Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTIVGpY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTIVGpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:45:23 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:11907 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263018AbTIVGpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:45:22 -0400
Date: Mon, 22 Sep 2003 08:44:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jos Hulzink <josh@stack.nl>
cc: Roger Luethi <rl@hellgate.ch>, acpi-devel@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
In-Reply-To: <200309211650.18881.josh@stack.nl>
Message-ID: <Pine.GSO.4.21.0309220842520.4957-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Sep 2003, Jos Hulzink wrote:
> On Saturday 20 Sep 2003 15:17, Geert Uytterhoeven wrote:
> > If I turn off CONFIG_X86_UP_APIC I get:
> > | ACPI disabled because your bios is from 00 and too old
> > | You can enable it with acpi=force
> > | Sony Vaio laptop detected.
> >
> > and ACPI is disabled. Halt doesn't work.
> >
> > If I then pass `acpi=force' to explicitly enable ACPI, `halt' works again
> > and powers off the machine, but `reboot' causes a black screen with IDE
> > disk spun down, but no restart.
> >
> > Gr{oetje,eeting}s,
> 
> My PIII 650 with 2000 BIOS boots linux with acpi disabled for the same reason, 
> unless force ACPI support. It reboots fine with ACPI forced. The ACPI support 
> of this Intel BX mobo is good, so this is a false negative IMHO. (I wonder if 
> the check is correct, shouldn't it say 2000 instead of 00 ?)

If year < 90 it adds 2000 so that's OK. But the code needs ACPI from 2001 or
more recent, so my BIOS from 2000 fails...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

