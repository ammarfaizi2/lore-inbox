Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265457AbUAAWBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbUAAWAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:00:45 -0500
Received: from luli.rootdir.de ([213.133.108.222]:63468 "EHLO luli.rootdir.de")
	by vger.kernel.org with ESMTP id S265434AbUAAVw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:52:57 -0500
X-Qmail-Scanner-Mail-From: claas@rootdir.de via luli
X-Qmail-Scanner: 1.20 (Clear:RC:1(217.186.137.29):SA:0(-4.4/5.0):. Processed in 0.29887 secs)
Date: Thu, 1 Jan 2004 22:53:08 +0100
From: Claas Langbehn <claas@rootdir.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: atyfb broken
Message-ID: <20040101215308.GA16921@rootdir.de>
References: <20031230212609.GA4267@rootdir.de> <Pine.GSO.4.58.0401011951510.2916@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0401011951510.2916@waterleaf.sonytel.be>
Reply-By: Sun Jan  4 22:48:19 CET 2004
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0 i686
X-No-archive: yes
X-Uptime: 22:48:19 up 2 days, 11:23,  8 users,  load average: 0.48, 0.75, 0.69
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

> > I have got an HP omnibook 4150B. When booting with atyfb,
> > the kernel messages look great:
> >
> > atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 50 Mhz MCLK
> > fb0: ATY Mach64 frame buffer device on PCI
> >
> > But either the screen is black and I see only the cursor and Background
> > colors (CONFIG_FRAMEBUFFER_CONSOLE disabled), but X11 starts fine.
> 
> Does your notebook work with the atyfb in 2.4.23? With the one in 2.4.22 and
> earlier?

with 2.4.23 it does not work either.

dmesg says:

atyfb: using auxiliary register aperture
atyfb: Mach64 BIOS is located at c0000, mapped at c00c0000.
atyfb: BIOS contains driver information table.
atyfb: colour active matrix monitor detected: CPT CLAA141XB01        
        id=10, 1024x768 pixels, 262144 colours (LT mode)
        supports 60 Hz refresh rates, default 60 Hz
        LCD CRTC parameters: 15384 167 127 130 0 17 805 767 769 6
atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL,
       230 MHz PLL, 83 Mhz MCLK, 125 Mhz XCLK
Console: switching to colour frame buffer device 80x25
fb0: ATY Mach64 frame buffer device on PCI
                        

When booting the screen gets slowly flooded with white. 
X11 works anyway.

dmesg's output shows different MCLK and XCLK with kernel 2.4.23 
(see above).


Regards,claas
