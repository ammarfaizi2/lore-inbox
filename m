Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWAEJyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWAEJyo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 04:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWAEJyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 04:54:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56078 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750704AbWAEJyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 04:54:43 -0500
Date: Thu, 5 Jan 2006 10:54:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] the scheduled removal of obsolete OSS drivers
Message-ID: <20060105095442.GZ3831@stusta.de>
References: <20060103114900.GA3831@stusta.de> <1136443154.24475.2.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136443154.24475.2.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 01:39:14AM -0500, Lee Revell wrote:
> On Tue, 2006-01-03 at 12:49 +0100, Adrian Bunk wrote:
> >  sound/oss/nm256.h                          |  292 
> >  sound/oss/nm256_audio.c                    | 1709 -----
> >  sound/oss/nm256_coeff.h                    | 4697 ---------------- 
> 
> This driver must not be removed.  The ALSA driver is broken.

thanks for this remark, I'll send an updated patch.

> Here's why:
> 
> On Tue, 2006-01-03 at 13:14 +0100, Takashi Iwai wrote: 
> > Unfortunately, it's impossible to fix this without a test hardware.
> > The condition is worst:  No datasheet, a picky chipset, a pure
> > reverse-engineered driver code.
> > 
> > 
> > Takashi
> > 
> 
> See https://bugtrack.alsa-project.org/alsa-bug/view.php?id=328 for details.

I'll ermove this driver from my list until this bug is resolved.

> Lee

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

