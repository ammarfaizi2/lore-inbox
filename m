Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269371AbUINO6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269371AbUINO6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269021AbUINO6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:58:17 -0400
Received: from gprs40-135.eurotel.cz ([160.218.40.135]:27569 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269371AbUINOxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:53:08 -0400
Date: Tue, 14 Sep 2004 16:52:50 +0200
From: Pavel Machek <pavel@suse.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: seife@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: HP/Compaq (Winbond) SD/MMC reader supported
Message-ID: <20040914145250.GA27621@elf.ucw.cz>
References: <41383D02.5060709@drzeus.cx> <20040913223827.GA28524@elf.ucw.cz> <41467216.6070508@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41467216.6070508@drzeus.cx>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Hmm, it does something here on my nx5000... It causes 2 "bad parity
> >from KBD" errors and then freezes boot. But the chip is detected and I
> >see 
> >
> >mmc0: W83L51xD id f00 at 0x248 irq 1 dma 0
> >
> >message. (How do I guess right values for irq? I thought that
> >interference with keyboard means it uses irq 1, but it is probably not
> >the case, and default values did not work, too).
> >
> >I'll try turning off ALSA because it actually freezes machine only
> >after alsa is loaded.
> > 
> >
> You seem to be running an old version of the driver. The ports for the 
> driver are also often populated by SuperIO chip. The detection routine 
> was a bit optimistic in the earlier versions so it started resetting the 
> wrong hardware.
> 
> As of writing the latest version is 0.7 and a patch can be downloaded at:
> 
> http://projects.drzeus.cx/wbsd/download.php?get=files/wbsd-0.7.patch

Hmm, now I get "Unknown hardware (id f00) found at 2e". I'll try to
investigate further.

									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
