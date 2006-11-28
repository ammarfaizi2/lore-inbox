Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935634AbWK1GHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935634AbWK1GHV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 01:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935642AbWK1GHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 01:07:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17928 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S935634AbWK1GHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 01:07:20 -0500
Date: Tue, 28 Nov 2006 07:07:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Joe Feise <jfeise@feise.com>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [2.6 patch] remove the broken VIDEO_ZR36120 driver
Message-ID: <20061128060723.GA15364@stusta.de>
References: <20061125191510.GB3702@stusta.de> <456BC973.1050309@feise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456BC973.1050309@feise.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 09:30:27PM -0800, Joe Feise wrote:
> Adrian Bunk wrote on 11/25/06 11:15:
> 
> > The VIDEO_ZR36120 driver has:
> > - already been marked as BROKEN in 2.6.0 three years ago and
> > - is still marked as BROKEN.
> > 
> > Drivers that had been marked as BROKEN for such a long time seem to be 
> > unlikely to be revived in the forseeable future.
> > 
> > But if anyone wants to ever revive this driver, the code is still 
> > present in the older kernel releases.
> 
> Hmm, there are people out there (like me) who still use it and have patched it
> to get it working on 2.6.x.

If you anyway have to patch your kernel, you can as well patch the 
complete driver into the kernel.

Three years after 2.6.0 the in-kernel driver is still marked as BROKEN, 
and e.g. the current Video4Linux API change might leave this driver 
unfixed and even more broken.

Is anyone working on getting this driver into shape NOW?
If not, it will still be at any time possible to submit a fixed version 
of this driver for re-inclusion.

> -Joe

cu
Adrian

BTW: Please don't drop people from the Cc.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

