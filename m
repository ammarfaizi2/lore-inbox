Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756412AbWKRTzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412AbWKRTzW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 14:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756410AbWKRTzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 14:55:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9744 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755243AbWKRTzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 14:55:20 -0500
Date: Sat, 18 Nov 2006 20:55:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: adaplas@pol.net, James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove broken video drivers
Message-ID: <20061118195519.GZ31879@stusta.de>
References: <20061118000235.GV31879@stusta.de> <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0611181132230.7667@xplor.biophys.uni-duesseldorf.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2006 at 11:34:41AM +0100, Michael Schmitz wrote:
> On Sat, 18 Nov 2006, Adrian Bunk wrote:
> 
> > This patch removes video drivers that:
> > - had already been marked as BROKEN in 2.6.0 three years ago and
> > - are still marked as BROKEN.
> >
> > These are the following drivers:
> > - FB_CYBER
> > - FB_VIRGE
> > - FB_RETINAZ3
> > - FB_ATARI
> 
> FB_ATARI has just been revived. Geert has a preliminary patch; I'll send
> the final one soonish.

Thanks for this information.

Are any of the following Atari options that are also on my
"BROKEN since at least 2.6.0" list also being revived?

- HADES (arch/m68k/Kconfig)
- ATARI_ACSI (drivers/net/Kconfig)
- ATARI_BIONET (drivers/net/Kconfig)
- ATARI_PAMSNET (drivers/net/Kconfig)
- ATARI_SCSI (drivers/scsi/Kconfig)

> 	Michael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

