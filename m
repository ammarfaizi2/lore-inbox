Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUG2VaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUG2VaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267269AbUG2V2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:28:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52452 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265245AbUG2VXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:23:19 -0400
Date: Thu, 29 Jul 2004 23:23:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: paul@linuxaudiosystems.com, thomas@undata.org, perex@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ALSA rme9652/hdsp: remove inlines
Message-ID: <20040729212310.GF23589@fs.tum.de>
References: <20040711102637.GA4701@fs.tum.de> <s5hisctcrou.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hisctcrou.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 02:53:37PM +0200, Takashi Iwai wrote:
> At Sun, 11 Jul 2004 12:26:37 +0200,
> Adrian Bunk wrote:
> > 
> > The patch below removes all inlines from hdsp.c. As a side effect, it
> > showed that snd_hdsp_9652_disable_mixer() is completely unused, and it's
> > therefore also removed in the patch.
> > 
> > 
> > An alternative approach to removing the inlines would be to keep all
> > inlines that are _really_ required and reorder the functions in the file
> > accordingly.
> 
> Just removing inline should be fine, since they are all no
> time-critical functions.  I'll apply it to ALSA tree.

It seems to be missing in the copy of the ALSA tree included in 
2.6.8-rc2-mm1 ?

> thanks,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

