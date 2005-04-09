Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVDIBto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVDIBto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVDIBto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:49:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42505 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261249AbVDIBtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:49:41 -0400
Date: Sat, 9 Apr 2005 03:49:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm2
Message-ID: <20050409014940.GB4770@stusta.de>
References: <20050408030835.4941cd98.akpm@osdl.org> <Pine.LNX.4.62.0504090125171.2455@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504090125171.2455@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2005 at 01:28:47AM +0200, Jesper Juhl wrote:
> On Fri, 8 Apr 2005, Andrew Morton wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/
> > 
> 
> Still doesn't build for me with my usual config (available upon request) 
> unless I enable ACPI :
> 
> ...
>   CC      arch/i386/kernel/setup.o
> arch/i386/kernel/setup.c:96: error: parse error before "acpi_sci_flags"
> arch/i386/kernel/setup.c:96: warning: type defaults to `int' in declaration of `acpi_sci_flags'
> arch/i386/kernel/setup.c:96: warning: data definition has no type or storage class
> arch/i386/kernel/setup.c: In function `parse_cmdline_early':
> arch/i386/kernel/setup.c:811: error: request for member `trigger' in something not a structure or union
> arch/i386/kernel/setup.c:814: error: request for member `trigger' in something not a structure or union
> arch/i386/kernel/setup.c:817: error: request for member `polarity' in something not a structure or union
> arch/i386/kernel/setup.c:820: error: request for member `polarity' in something not a structure or union
> make[1]: *** [arch/i386/kernel/setup.o] Error 1
> make: *** [arch/i386/kernel] Error 2

This seem to be the ACPI=y, ACPI_BOOT=n errors we already saw in -mm1 
Len will send a patch for.

> Jesper Juhl

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

