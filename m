Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVJ3SiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVJ3SiY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 13:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVJ3SiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 13:38:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3600 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932206AbVJ3SiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 13:38:22 -0500
Date: Sun, 30 Oct 2005 19:38:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20051030183821.GI4180@stusta.de>
References: <20051030105118.GW4180@stusta.de> <p73mzkqubf4.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73mzkqubf4.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 07:06:39PM +0100, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > This patch schedules obsolete OSS drivers (with ALSA drivers that support the
> > same hardware) for removal.
> > 
> > Scheduling the via82cxxx driver for removal was ACK'ed by Jeff Garzik.
> 
> I would prefer if the ICH driver be kept. It works just fine on near
> all my systems and has a much smaller binary size than the ALSA
> variant. Moving to ALSA would bloat the kernels considerably.

???

$ ls -la sound/oss/i810_audio.o sound/pci/intel8x0.o
-rw-rw-r--  1 bunk bunk 38056 2005-10-30 13:43 sound/oss/i810_audio.o
-rw-rw-r--  1 bunk bunk 34344 2005-10-30 13:44 sound/pci/intel8x0.o
$ 

The general decision for the OSS -> ALSA move was long ago.

If you have a real issue with the ALSA driver please submit a proper 
bug report to the ALSA bug tracking system and tell me the bug number.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

