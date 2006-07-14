Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWGNQdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWGNQdO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWGNQdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:33:14 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32518 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161248AbWGNQdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:33:12 -0400
Date: Fri, 14 Jul 2006 18:33:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/ide/: cleanups
Message-ID: <20060714163310.GA18427@stusta.de>
References: <20060711141637.GS13938@stusta.de> <1152873806.23037.73.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152873806.23037.73.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 08:43:26PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2006-07-11 at 16:16 +0200, Adrian Bunk wrote:
> > This patch contains the following clenups:
> > - setup-pci.c: #if 0 the unused ide_pci_unregister_driver()
> > - ide.c: remove the unused EXPORT_SYMBOL(ide_register_hw)
> 
> Unused ? The PowerMac media-bay code uses it. It's not yet module-able
> but I haven't given up on it just yet :)

It's even used by drivers/ide/arm/bast-ide.c that can be modular (which 
I missed). -mm therefore contains the updated version I sent later in 
this thread that does no longer contain this unexport.

> Ben.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

