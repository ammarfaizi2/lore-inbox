Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVJ3Ttx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVJ3Ttx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVJ3Ttx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:49:53 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32528 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932239AbVJ3Ttw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:49:52 -0500
Date: Sun, 30 Oct 2005 20:49:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20051030194951.GJ4180@stusta.de>
References: <20051030105118.GW4180@stusta.de> <p73mzkqubf4.fsf@verdi.suse.de> <20051030183821.GI4180@stusta.de> <200510302035.49765.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510302035.49765.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 08:35:49PM +0100, Andi Kleen wrote:
> On Sunday 30 October 2005 19:38, Adrian Bunk wrote:
> 
> > ???
> > 
> > $ ls -la sound/oss/i810_audio.o sound/pci/intel8x0.o
> > -rw-rw-r--  1 bunk bunk 38056 2005-10-30 13:43 sound/oss/i810_audio.o
> > -rw-rw-r--  1 bunk bunk 34344 2005-10-30 13:44 sound/pci/intel8x0.o
> > $ 
> > 
> > The general decision for the OSS -> ALSA move was long ago.
> 
> If you compare the complete size of ALSA+driver vs OSS+driver then
> OSS wins easily on the bloat department.

If this is your problem then you should have vetoed the inclusion of 
ALSA into the kernel.

> > If you have a real issue with the ALSA driver please submit a proper 
> > bug report to the ALSA bug tracking system and tell me the bug number.
> 
> Avoiding bloat is a real issue.

OK, what is your plan to make ALSA non-bloated?

E.g. it's clear that unused code or unused EXPORT_SYMBOL's in the kernel 
are bloat, so I am working on eliminating such bloat.

If you consider ALSA too bloated you should help on solving this issue 
instead of insisting on keeping OSS.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

