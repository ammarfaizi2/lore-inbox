Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290833AbSBLIx4>; Tue, 12 Feb 2002 03:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290834AbSBLIxg>; Tue, 12 Feb 2002 03:53:36 -0500
Received: from mail.sonytel.be ([193.74.243.200]:31126 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S290833AbSBLIxc>;
	Tue, 12 Feb 2002 03:53:32 -0500
Date: Tue, 12 Feb 2002 09:52:52 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: George Bonser <george@gator.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux console at boot
In-Reply-To: <CHEKKPICCNOGICGMDODJKEPAGBAA.george@gator.com>
Message-ID: <Pine.GSO.4.21.0202120950480.12840-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, George Bonser wrote:
> Is there any way to stop the console scrolling during boot? My reason
> for this is I am trying to troubleshoot a boot problem with
> 2.4.18-pre7 and I would like to give a more useful report than "it
> won't boot" but the screen outputs information every few seconds and I
> can't "freeze" the display so I can copy down the initial error(s).
> 
> This is an Intel unit using the standard console (not serial console).
> pre7 will not boot but pre6 boots every time.

On Amiga (m68k and PPC) we have a `debug=mem' option that will write all kernel
messages to a 256 KiB block (marked with a magic number) of Chip RAM. If the
system crashes early, you can reboot into AmigaOS and run a special utility
that finds the 256 KiB block (Chip RAM is not completely erased on reboot) and
extracts the messages.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

