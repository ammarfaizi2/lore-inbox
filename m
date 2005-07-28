Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVG1Pcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVG1Pcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 11:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVG1OOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:14:34 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52228 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261485AbVG1OOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:14:23 -0400
Date: Thu, 28 Jul 2005 16:14:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050728141419.GH3528@stusta.de>
References: <20050726150837.GT3160@stusta.de> <20050727183942.GA2964@roadwarrior.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727183942.GA2964@roadwarrior.mcmartin.ca>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 02:39:42PM -0400, Kyle McMartin wrote:
> On Tue, Jul 26, 2005 at 05:08:37PM +0200, Adrian Bunk wrote:
> > This patch schedules obsolete OSS drivers (with ALSA drivers that 
> > support the same hardware) for removal.
> 
> oss/harmony.c can probably go, unless someone from parisc-linux
> objects. I've written a (working) replacement[1] for oss/ad1889.c
> which is in our cvs, and will go upstream shortly. oss/ad1889.c
> doesn't (and hasn't ever) worked, so it should probably be removed.
>...

:-)

The sooner your driver goes through the ALSA people in Linus' tree, the 
sooner we can schedule the OSS driver for removal.

> Cheers,
> Kyle McMartin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

