Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVFLK1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVFLK1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 06:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVFLK1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 06:27:52 -0400
Received: from witte.sonytel.be ([80.88.33.193]:2965 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261273AbVFLK1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 06:27:47 -0400
Date: Sun, 12 Jun 2005 12:27:36 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Willy Tarreau <willy@w.ods.org>
cc: subbie subbie <subbie_subbie@yahoo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: optional delay after partition detection at boot time
In-Reply-To: <20050612071213.GG28759@alpha.home.local>
Message-ID: <Pine.LNX.4.62.0506121225170.11197@numbat.sonytel.be>
References: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com>
 <20050612071213.GG28759@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005, Willy Tarreau wrote:
> On Sat, Jun 11, 2005 at 11:50:50PM -0700, subbie subbie wrote:
> >  I'm sure some of you have come across this annoying
> > issue, the kernel messages scroll way too fast for a
> > human to be able to read them (let alone vgrep them).
> > 
> >  I'm proposing two features;
> > 
> >  1. a configurable (boot time, via kernel command
> > line) delay between each and every print -- kind of
> > overkill, but may be useful sometimes. 
> >  
> >  2. a configurable (boot time, via kernel command
> > line) delay after partition detection, so that a
> > humble system administrator would be able to actually
> > find out which partition he should specify at boot
> > time in order to boot his system.   This is especially
> > annoying on newer SATA systems where sometimes disks
> > are detected as SCSI and sometimes as standard ATA
> > (depending on BIOS settings), I'm sure though that it
> > could be useful in a number of other cases.
> 
> What's the problem with "cat /proc/partitions" or "dmesg" ?
> You seem to want to slow down *every* boot just to identify
> a partition you need to find *once*. This seems overkill.

Or make the kernel print /proc/partitions when it is unable to mount root?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
