Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTBONnX>; Sat, 15 Feb 2003 08:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbTBONnX>; Sat, 15 Feb 2003 08:43:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2018 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262394AbTBONnV>; Sat, 15 Feb 2003 08:43:21 -0500
Date: Sat, 15 Feb 2003 14:53:11 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jochen Friedrich <jochen@scram.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.61: tms380tr.c no longer compiles
Message-ID: <20030215135311.GW20159@fs.tum.de>
References: <20030215090733.GV20159@fs.tum.de> <Pine.LNX.4.44.0302151034060.1719-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302151034060.1719-100000@gfrw1044.bocc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 10:35:33AM +0100, Jochen Friedrich wrote:

> Hi Adrian,

Hi Jochen,

> > drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> > drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> > drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> > drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> > drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> > drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> > drivers/net/tokenring/tms380tr.c: In function `tms380tr_init_adapter':
> > drivers/net/tokenring/tms380tr.c:1461: warning: long unsigned int
> 
> I wonder why my version of gcc didn't catch that one on my Alpha...
> 
> Please try this one:
>...

thanks, this fixed it.

I had to hand-apply your patch, are there some whitespaces that were
eaten by your MUA or something similar?

> Thanks,
> --jochen

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

