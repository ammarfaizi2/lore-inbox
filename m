Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbSL2Rfh>; Sun, 29 Dec 2002 12:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbSL2Rfh>; Sun, 29 Dec 2002 12:35:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5101 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266640AbSL2Rfg>; Sun, 29 Dec 2002 12:35:36 -0500
Date: Sun, 29 Dec 2002 18:43:52 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Erik Andersen <andersen@codepoet.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, bcollins@debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix 2.4.x ieee1394
Message-ID: <20021229174351.GA6114@fs.tum.de>
References: <200212172033.gBHKX6A32611@hera.kernel.org> <20021222112613.GA8743@codepoet.org> <20021229153821.GN27658@fs.tum.de> <20021229164409.GA5416@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021229164409.GA5416@codepoet.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 09:44:09AM -0700, Erik Andersen wrote:
> On Sun Dec 29, 2002 at 04:38:21PM +0100, Adrian Bunk wrote:
> > When I try 2.4.21-pre2 with your patch and the IEEE 1394 options you 
> > mention in your mail _nothing_ gets built inside the drivers/ieee1394 
> > directory and the error message at the final linking is:
> > 
> > <--  snip  -->
> > 
> > ...
> >         -o vmlinux
> > ld: cannot open drivers/ieee1394/ieee1394.o: No such file or directory
> > make: *** [vmlinux] Error 1
> > 
> > <--  snip  -->
> > 
> > 
> > How did you manage to get a kernel that actually compiles?
> > 
> 
> Sorry about that.  I missed a spot.  Here is the full fix:
>...

Thanks, I can confirm that this patch fixes it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

