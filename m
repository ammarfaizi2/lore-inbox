Return-Path: <linux-kernel-owner+w=401wt.eu-S1030287AbXAKXjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbXAKXjw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbXAKXjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:39:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2660 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030293AbXAKXju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:39:50 -0500
Date: Fri, 12 Jan 2007 00:39:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: add pci_get_legacy_ide_irq() (was: [2.6 patch] let BLK_DEV_AMD74XX depend on X86)
Message-ID: <20070111233954.GA7469@stusta.de>
References: <45A65C8A.9080601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A65C8A.9080601@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 04:49:30PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Adrian Bunk wrote:
> > 
> > It's unlikely that this driver will ever be of any use on other
> > architectures.
> 
> It is already used on PPC.
> 
> [ see arch/powerpc/platforms/maple/pci.c:maple_pci_get_legacy_ide_irq() ]

You can call me surprised.

>...
> Does the following patch fix the problem?
>...

Yes, it fixes the compilation.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

