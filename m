Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWAFRym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWAFRym (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWAFRym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:54:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16653 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964823AbWAFRyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:54:41 -0500
Date: Fri, 6 Jan 2006 18:54:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Message-ID: <20060106175436.GU12131@stusta.de>
References: <20060106173547.GR12131@stusta.de> <20060106174127.GE16093@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106174127.GE16093@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 05:41:28PM +0000, Russell King wrote:
> On Fri, Jan 06, 2006 at 06:35:47PM +0100, Adrian Bunk wrote:
> > Do not allow people to create configurations with CONFIG_BROKEN=y.
> > 
> > The sole reason for CONFIG_BROKEN=y would be if you are working on 
> > fixing a broken driver, but in this case editing the Kconfig file is 
> > trivial.
> > 
> > Never ever should a user enable CONFIG_BROKEN.
> 
> NACK.  MTD_OBSOLETE_CHIPS still hasn't been fixed and must be fixed
> _before_ this patch can go in.

The MTD_OBSOLETE_CHIPS patch is also part of the batch of patches I'm 
currently resending (it's coming in a few minutes).

@Andrew:
I agree with Russell on the ordering of the two patches.

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

