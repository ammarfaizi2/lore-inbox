Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWF0NLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWF0NLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 09:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWF0NLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 09:11:19 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44805 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932200AbWF0NLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 09:11:18 -0400
Date: Tue, 27 Jun 2006 15:11:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/mtd/devices/: remove dead _ecc code
Message-ID: <20060627131116.GL23314@stusta.de>
References: <20060621215840.GP9111@stusta.de> <1150928664.25491.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150928664.25491.34.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 12:24:24AM +0200, Thomas Gleixner wrote:
> On Wed, 2006-06-21 at 23:58 +0200, Adrian Bunk wrote:
> > This patch removes some code that is dead code after the
> > "Remove read/write _ecc variants" patch that went into Linus' tree.
> 
> Holy cow, are you even remotly knowing what you are doing ? 
> 
> Removing the xxx_ecc function pointers from the mtd structs does not
> remove the fundamental requirement of ECC for NAND FLASH.
> 
> I'm just waiting for the follow up patches which remove nand_ecc and the
> reed solomon library.
>...

nand_ecc isn't dead code.

But if I do understand correctly, you have pending patches to let the 
code your patch made dead code and my patch would have removed be used 
again?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

