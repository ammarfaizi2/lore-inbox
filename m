Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266460AbSLWOx5>; Mon, 23 Dec 2002 09:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSLWOx5>; Mon, 23 Dec 2002 09:53:57 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:8446 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266460AbSLWOx4>;
	Mon, 23 Dec 2002 09:53:56 -0500
Date: Mon, 23 Dec 2002 16:00:47 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: James Simmons <jsimmons@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Stian Jordet <liste@jordet.nu>, Allan Duncan <allan.d@bigpond.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.51
In-Reply-To: <Pine.LNX.4.33.0212110720540.2617-100000@maxwell.earthlink.net>
Message-ID: <Pine.GSO.4.21.0212231557460.16361-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002, James Simmons wrote:
> > How well does this driver work if you don't have a firmware
> > driver initialize the card? aka a pci option ROM.
> >
> > I am interested because with LinuxBIOS it is still a pain to run
> > PCI option roms, and I don't necessarily even have then if it a
> > motherboard with video.  There are some embedded/non-x86 platforms
> > with similar issues.
> >
> > My primary interest is in the cheap ATI Rage XL chip that is on many
> > server board. PCI Vendor/device  id 1002:4752 (rev 27) from lspci.
> >
> > If nothing else if some one could point me to some resources on
> > how to get the appropriate documentation from the video chipset
> > manufacturers I would be happy.
> >
> > But I did want to at least point that running a system with out bios
> > initialized video was certainly among the cases that are used.
> 
> Unfortunely ATI doesn't like to release info on what needs to be done to
> initialize without frimware. I really wish this was the case. I did see
> email back about someone getting a mach64 card working without firmware.
> They used a bus analysiser to do this. I will see what kind of patches I
> can dig up.

Indeed, just ask Steve Longerbeam <stevel@mvista.com>.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



