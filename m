Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTH3HVH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 03:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTH3HVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 03:21:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28636 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261613AbTH3HVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 03:21:05 -0400
Date: Sat, 30 Aug 2003 09:20:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill CONFIG_KCORE_AOUT
Message-ID: <20030830072058.GI7038@fs.tum.de>
References: <200308252332.46101.cijoml@volny.cz> <20030826105145.GC7038@fs.tum.de> <20030826135323.2c33e697.akpm@osdl.org> <20030830070513.GH7038@fs.tum.de> <20030830001159.013cc6d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030830001159.013cc6d2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 30, 2003 at 12:11:59AM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > The patch below kills CONFIG_KCORE_AOUT.
> > 
> >  I've tested the compilation with 2.6.0-test4.
> 
> Not on m68knommu or h8300 you haven't :)  They both
> select CONFIG_KCORE_AOUT in defconfig.

The Kconfig files on these architectures had the interesting "feature" 
that both KCORE_AOUT and KCORE_ELF were enabled unconditionally...

Besides, I always consider the defconfig files as some kinds of 
generated files and since they only give default answers for
"make defconfig" I didn't see the big need for manually editing every 
single defconfig file.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

