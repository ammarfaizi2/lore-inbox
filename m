Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbTGTWOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 18:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268773AbTGTWOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 18:14:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57330 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268700AbTGTWOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 18:14:02 -0400
Date: Mon, 21 Jul 2003 00:28:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>, Jens Axboe <axboe@suse.de>
Subject: Re: how to use "ATAPI:" protocol for IDE CD/RWs??
Message-ID: <20030720222854.GI26422@fs.tum.de>
References: <Pine.LNX.4.53.0307200606120.17848@localhost.localdomain> <20030720122653.C22265@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720122653.C22265@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 20, 2003 at 12:26:53PM +0200, Rudo Thomas wrote:
> >   are there known problems with trying to access IDE CD/RWs directly
> > through the IDE drivers, rather than using SCSI emulation?  i've tried
> > testing cdrecord using the "dev=ATAPI:x,y,z" option, and am having
> > no luck.
> 
> Take a look at
> http://www.codemonkey.org.uk/post-halloween-2.5.txt
> 
> Excerpt:
> 
> CD Recording.
> ~~~~~~~~~~~~
> - Jens Axboe added the ability to use DMA for writing CDs on
>   ATAPI devices. Writing CDs should be much faster than it
>   was in 2.4, and also less prone to buffer underruns and the like.
> - Updated cdrecord in rpm and tar.gz can be found at
>   *.kernel.org/pub/linux/kernel/people/axboe/tools/
>...

@Dave:
What about writing "You need cdrecord >= 2.0 for this." instead?

> Rudo.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

