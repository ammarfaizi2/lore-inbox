Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTJOTDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTJOTDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:03:51 -0400
Received: from [80.88.36.193] ([80.88.36.193]:22429 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264093AbTJOTDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:03:41 -0400
Date: Wed, 15 Oct 2003 21:03:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Erik Mouw <erik@harddisk-recovery.com>
cc: Nikita Danilov <Nikita@Namesys.COM>, Josh Litherland <josh@temp123.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
In-Reply-To: <20031015160430.GH24799@bitwizard.nl>
Message-ID: <Pine.GSO.4.21.0310151856520.21132-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003, Erik Mouw wrote:
> On Wed, Oct 15, 2003 at 06:33:03PM +0400, Nikita Danilov wrote:
> > Trend is that CPU is getting faster and faster with respect to the
> > disk. So, even if it were hard to find such a CPU to-day, it will be
> > common place to-morrow.
> 
> I'm not too sure about this. It's my feeling that CPU speed and disk
> throughput grow about as fast. I don't have hard figures, so I can be
> proven wrong on this.

Well, let's take some (exotic :-) examples:

  - 1989: Amiga 500, 7.14 MHz 68000, expensive SCSI disk, 675 KB/s
  - 1992: Amiga 4000, 25 MHz 68040, IDE, 1.8 MB/s (SCSI with 5 MB/s should have
    been possible)
  - 1998: CHRP, 200 MHz 604e, UW-SCSI, 17 MB/s

The third CPU is ca. 25 times faster than the second (both in BogoMIPS as
kernel cross-compiles). The disk isn't 25 faster, though.

Now you can buy a machine with a CPU that's 25 times faster again, but please
show me a 400 MB/s disk...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

