Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTKXO0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 09:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbTKXO0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 09:26:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2762 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263650AbTKXO0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 09:26:12 -0500
Date: Mon, 24 Nov 2003 15:26:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: glee@gnupilgrims.org
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test10 - BINFMT_ELF
Message-ID: <20031124142605.GL16828@fs.tum.de>
References: <Pine.LNX.4.44.0311231804170.17378-100000@home.osdl.org> <3FC1BBF1.A4D05AD@eyal.emu.id.au> <20031124090507.GB3391@gandalf.chinesecodefoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031124090507.GB3391@gandalf.chinesecodefoo.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 05:05:07PM +0800, glee@gnupilgrims.org wrote:
> On Mon, Nov 24, 2003 at 07:06:09PM +1100, Eyal Lebedinsky wrote:
> > It is unusual that a Y/n option includes M in the help text:
> > ...
> > To compile this as a module, choose M here: the module will be called
> > binfmt_elf. Saying M or N here is dangerous because some crucial
> > programs on your system might be in ELF format.
> > 
> > Kernel support for ELF binaries (BINFMT_ELF) [Y/n/?] (NEW) y
> 
> I think Adrian had forgotten to update the help text.


Yes, your patch is obviously correct.


> 	- g.
> 
> 

> --- linux-2.6.0-test10/fs/Kconfig.binfmt.orig	2003-11-24 16:44:36.000000000 +0800
> +++ linux-2.6.0-test10/fs/Kconfig.binfmt	2003-11-24 16:45:10.000000000 +0800
> @@ -23,10 +23,6 @@
>  	  ld.so (check the file <file:Documentation/Changes> for location and
>  	  latest version).
>  
> -	  To compile this as a module, choose M here: the module will be called
> -	  binfmt_elf. Saying M or N here is dangerous because some crucial
> -	  programs on your system might be in ELF format.
> -
>  config BINFMT_FLAT
>  	tristate "Kernel support for flat binaries"
>  	depends on !MMU || SUPERH


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

