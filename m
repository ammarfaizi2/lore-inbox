Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRJJAZM>; Tue, 9 Oct 2001 20:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273818AbRJJAZC>; Tue, 9 Oct 2001 20:25:02 -0400
Received: from [209.250.60.207] ([209.250.60.207]:42764 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S273065AbRJJAYm>; Tue, 9 Oct 2001 20:24:42 -0400
Date: Tue, 9 Oct 2001 19:24:59 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Michael Peddemors <michael@wizard.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Framebuffer detection problems, 2.4.9
Message-ID: <20011009192459.A26019@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Michael Peddemors <michael@wizard.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <1002670696.4112.285.camel@mistress>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1002670696.4112.285.camel@mistress>; from michael@wizard.ca on Tue, Oct 09, 2001 at 04:38:15PM -0700
X-Uptime: 7:18pm  up 1 day,  8:44,  0 users,  load average: 0.38, 0.85, 0.94
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 04:38:15PM -0700, Michael Peddemors wrote:
> I seldom dive into the graphical end of things myself, but this one has
> had me stumped for the last week and a half..
> 
> I have a working ThinClient setup, that loads it's kernel via tftpd and
> mknbi, with the 'vga=ask' option..
> On one machine, with a Cirrus Logic card, (Cirrus Framebuffer support
> compiled in) things work fine, but on all my other boxes with VESA
> complaint cards, I cannot get it to use the VESA framebuffer, or
> seemingly to detect the VESA devices with this kernel, although we can
> on detect and pass modes using LILO on similar kernels.
> 
> I have of course read as many how-to's as possible, and the svga.txt
> file seems to indicate that if I use the vga=ask option, and then run
> scan it should show all VESA modes as well, (It does detect it as a VESA
> VGA card), but the /fb/vesafb.txt seems to indicate that it won't show
> the modes..

It doesn't show the modes.  You have to enter one yourself, or tell it
to LILO.  /fb/vesafb.txt has more information about the varying modes
availible.  Read the whole file if you haven't already.  Be sure to add
0x200 as documented.

> I see that in video.S CONFIG_VIDEO_VESA is harddefined, but I cannot
> quite understand why I cannot enter a VESA mode that works..
> I tried 313, 0313, and the decimal equivs 787 and 0787 but it keeps
> returning that as an invalid mode..  This occurs on several machines,
> all with recent video cards, that are VESA compliant, and listed as
> compatible.. the motherboards all use recent BIOS's but still no joy..
> 
> I will accept help here, or can someone point me to a good mailing list
> to work this out?
> 
> -- 
> "Catch the Magic of Linux..."
> --------------------------------------------------------
> Michael Peddemors - Senior Consultant
> LinuxAdministration - Internet Services
> NetworkServices - Programming - Security
> Wizard IT Services http://www.wizard.ca
> Linux Support Specialist - http://www.linuxmagic.com
> --------------------------------------------------------
> (604)589-0037 Beautiful British Columbia, Canada
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell
Those that would give up a necessary freedom for temporary safety
deserver neither freedom nor safety.
			-- Ben Franklin
