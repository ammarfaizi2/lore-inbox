Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275397AbTHIUBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 16:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275395AbTHIUBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 16:01:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48837 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S275397AbTHIUBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 16:01:46 -0400
Date: Sat, 9 Aug 2003 22:01:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm2: BTTV build error
Message-ID: <20030809200139.GO16091@fs.tum.de>
References: <20030730223810.613755b4.akpm@osdl.org> <20030731150648.GG22991@fs.tum.de> <20030804091302.GH24453@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804091302.GH24453@bytesex.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 11:13:02AM +0200, Gerd Knorr wrote:
> > > +bttv-driver-update.patch
> 
> >   CC      drivers/media/video/bttv-cards.o
> > drivers/media/video/bttv-cards.c: In function `pvr_boot':
> > drivers/media/video/bttv-cards.c:2549: error: incompatible types in 
> > initialization
> > drivers/media/video/bttv-cards.c:2552: warning: implicit declaration of 
> > function `request_firmware'
> 
> Hmm, must investigate.  Any change if you toggle CONFIG_FW_LOADER?
>...

I can't reproduce it in >= -mm3 and I don't have my -mm2 tree anymore.

I assume that whatever caused it, it's fixed.

>   Gerd

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

