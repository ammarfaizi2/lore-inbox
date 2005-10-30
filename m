Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVJ3PM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVJ3PM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVJ3PM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:12:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30478 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750839AbVJ3PM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:12:58 -0500
Date: Sun, 30 Oct 2005 16:12:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20051030151256.GZ4180@stusta.de>
References: <20051030105118.GW4180@stusta.de> <20051030142752.GE6475@tachyon.int.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030142752.GE6475@tachyon.int.mcmartin.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 09:27:52AM -0500, Kyle McMartin wrote:
> On Sun, Oct 30, 2005 at 11:51:18AM +0100, Adrian Bunk wrote:
> > 
> > This patch schedules obsolete OSS drivers (with ALSA drivers that support the
> > same hardware) for removal.
> >
> 
> I didn't see it here, but SOUND_AD1889 can definitely be removed
> as well. The driver never worked properly to begin with. This was
> ACK'd by the author last time this thread reared it's head.

ALSA bugs [1] #1301 and #1302 are still open.

If they are resolved, SOUND_AD1889 will part of the next batch of OSS 
driver removal a few months from now.

> Cheers,
> 	Kyle

cu
Adrian

[1] https://bugtrack.alsa-project.org/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

