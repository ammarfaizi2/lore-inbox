Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWCTKrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWCTKrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWCTKrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:47:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37386 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751066AbWCTKrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:47:14 -0500
Date: Mon, 20 Mar 2006 11:47:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "S. Umar" <umar@compsci.cas.vanderbilt.edu>, perex@suse.cz,
       alsa-devel@lists.sourceforge.net, Marcus Hartig <m.f.h@web.de>
Subject: Re: 2.6.16-rc6: known regressions (v2)
Message-ID: <20060320104708.GA22317@stusta.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <s5hmzfost2h.wl%tiwai@suse.de> <200603181427.14393.kernel-stuff@comcast.net> <200603181446.23034.kernel-stuff@comcast.net> <s5hacbl2z1h.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hacbl2z1h.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 11:25:30AM +0100, Takashi Iwai wrote:
> At Sat, 18 Mar 2006 14:46:22 -0500,
> Parag Warudkar wrote:
> > 
> > On Saturday 18 March 2006 14:27, Parag Warudkar wrote:
> > > On Friday 17 March 2006 15:40, Takashi Iwai wrote:
> > > > The last patch seems incomplete.  Please try the patch below instead.
> > > > (This time with a changelog :)
> > > >
> > > >
> > > > Takashi
> > 
> > Additionally I get  azx_get_response timeout in dmesg with the new patch.
> > Sound works ok despite of that though.
> 
> That's why jack sensing doesn't work for you.  The jack sensing and
> auto-muting requies unsolicited events.
> 
> It's likely a problem of ACPI or whatever related with irq routing.

Both reporters said it worked in 2.6.15, so if the regression is related 
to irq routing it should be visible in the dmesg.

Parag, Marcus, please send an email with both a dmesg of 2.6.15 and a 
dmesg of 2.6.16-rc6 (or 2.6.16) attached.

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

