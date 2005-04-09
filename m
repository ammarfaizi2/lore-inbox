Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVDIBze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVDIBze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 21:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVDIBzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 21:55:33 -0400
Received: from mail.dif.dk ([193.138.115.101]:18321 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261253AbVDIBzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 21:55:12 -0400
Date: Sat, 9 Apr 2005 03:57:42 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm2
In-Reply-To: <20050409014940.GB4770@stusta.de>
Message-ID: <Pine.LNX.4.62.0504090356140.2455@dragon.hyggekrogen.localhost>
References: <20050408030835.4941cd98.akpm@osdl.org>
 <Pine.LNX.4.62.0504090125171.2455@dragon.hyggekrogen.localhost>
 <20050409014940.GB4770@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2005, Adrian Bunk wrote:

> On Sat, Apr 09, 2005 at 01:28:47AM +0200, Jesper Juhl wrote:
> > On Fri, 8 Apr 2005, Andrew Morton wrote:
> > 
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/
> > > 
> > 
> > Still doesn't build for me with my usual config (available upon request) 
> > unless I enable ACPI :
> > 
> > ...
> >   CC      arch/i386/kernel/setup.o
> > arch/i386/kernel/setup.c:96: error: parse error before "acpi_sci_flags"
> > arch/i386/kernel/setup.c:96: warning: type defaults to `int' in declaration of `acpi_sci_flags'
> > arch/i386/kernel/setup.c:96: warning: data definition has no type or storage class
> > arch/i386/kernel/setup.c: In function `parse_cmdline_early':
> > arch/i386/kernel/setup.c:811: error: request for member `trigger' in something not a structure or union
> > arch/i386/kernel/setup.c:814: error: request for member `trigger' in something not a structure or union
> > arch/i386/kernel/setup.c:817: error: request for member `polarity' in something not a structure or union
> > arch/i386/kernel/setup.c:820: error: request for member `polarity' in something not a structure or union
> > make[1]: *** [arch/i386/kernel/setup.o] Error 1
> > make: *** [arch/i386/kernel] Error 2
> 
> This seem to be the ACPI=y, ACPI_BOOT=n errors we already saw in -mm1 

Actually, I get these errors with ACPI=n, ACPI_BOOT=y, not the reverse as 
you say.


> Len will send a patch for.
> 
Ok, I was not aware of that, will be looking forward to it :)


-- 
Jesper

