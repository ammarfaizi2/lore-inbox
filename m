Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVAICGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVAICGL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 21:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVAICGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 21:06:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26128 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262200AbVAICGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 21:06:02 -0500
Date: Sun, 9 Jan 2005 03:05:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] small ftape cleanups
Message-ID: <20050109020556.GM14108@stusta.de>
References: <200501082336.j08Na0ha003117@hera.kernel.org> <1105231821.12004.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105231821.12004.19.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 12:50:22AM +0000, Alan Cox wrote:

> The changeset below was submitted with the wrong documentation. Any
> chance of someone providing the right documentation to the actual large
> change to ftape below (which does look sane but nothign to do with rio)

s/rio/ftape/ and the description is correct.

> > ChangeSet 1.2406, 2005/01/08 14:19:45-08:00, bunk@stusta.de
> > 
> > 	[PATCH] small ftape cleanups
> > 	
> > 	The patch below does cleanups under drivers/char/rio/ including the
> > 	following:
> > 	
> > 	- remove some completely unused code
> > 	- make some needlessly global code static
> > 	
> > 	Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> > 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> > 
> > 
> > 
> >  compressor/zftape-compress.c |    4 --
> >  lowlevel/fc-10.c             |    4 +-
> >  lowlevel/fdc-io.c            |   67 ++++++-------------------------------------
> >  lowlevel/fdc-io.h            |    5 ---
> >  lowlevel/ftape-bsm.c         |    8 ++++-

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

