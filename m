Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423141AbWJTWHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423141AbWJTWHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWJTWHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:07:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32264 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S2992792AbWJTWHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:07:19 -0400
Date: Sat, 21 Oct 2006 00:07:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] more helpful WARN_ON and BUG_ON messages
Message-ID: <20061020220717.GY3502@stusta.de>
References: <4538F81A.2070007@redhat.com> <20061020214101.GX3502@stusta.de> <45394615.5050406@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45394615.5050406@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 04:56:37PM -0500, Eric Sandeen wrote:
> Adrian Bunk wrote:
> 
> > Who really needs this considering it implies a size increase of the 
> > kernel image?
> > 
> > Using a kernel tree so unusual that you can't locate the source anymore 
> > sounds like an extremely rare and unintelligent situation, not something 
> > that must be handled.
> 
> Most debugging code makes the kernel bigger, slower... and easier to
> debug, no?
> 
> It's not a question of not being -able- to locate sources; it's a
> question of being able to look at a bug report and triage it quickly
> without digging around to find the kernel du jour that produced it.  *shrug*

It's not that BUGs were that frequent.

And with your suggestion "I suppose this could be put under CONFIG_DEBUG", 
it would anyway be turned off by nearly everyone.

> -Eric

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

