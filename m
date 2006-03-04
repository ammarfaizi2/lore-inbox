Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWCDOvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWCDOvP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 09:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWCDOvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 09:51:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63761 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751796AbWCDOvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 09:51:14 -0500
Date: Sat, 4 Mar 2006 15:51:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Otavio Salvador <otavio@debian.org>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: ALSA HDA Intel stoped to work in 2.6.16-*
Message-ID: <20060304145114.GY9295@stusta.de>
References: <87wtfhx7rm.fsf@nurf.casa> <s5hzmkcsv38.wl%tiwai@suse.de> <87slq3x3w1.fsf@nurf.casa> <s5hu0ajrbxv.wl%tiwai@suse.de> <87fym3w7m3.fsf@nurf.casa> <s5h3bi2a26o.wl%tiwai@suse.de> <8764mxiny5.fsf@nurf.casa> <s5h4q2fo0t4.wl%tiwai@suse.de> <87zmk6eq1t.fsf@nurf.casa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zmk6eq1t.fsf@nurf.casa>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 02:29:02AM -0300, Otavio Salvador wrote:
> Takashi Iwai <tiwai@suse.de> writes:
> 
> > Are you sure that your device has PCI SUB-system id 8086:2668 ?
> 
> oh no! Sorry!
> 
> 0000:00:1b.0 0403: 8086:2668 (rev 04)
>         Subsystem: 152d:0729
>                    ^^^^^^^^^

Can you make a patch with the correct id test whether it fixes your 
problem (without model=basic)?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

