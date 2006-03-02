Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWCBWcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWCBWcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 17:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWCBWcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 17:32:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60434 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750909AbWCBWcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 17:32:19 -0500
Date: Thu, 2 Mar 2006 23:32:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, dtor_core@ameritech.net,
       jgeorgas@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060302223218.GN9295@stusta.de>
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au> <20060302173840.GB9295@stusta.de> <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com> <20060302203245.GD9295@stusta.de> <9a8748490603021240t31f58ea4ycafae4ee8a12095c@mail.gmail.com> <20060302214055.GH9295@stusta.de> <Pine.LNX.4.61.0603022251270.13101@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603022251270.13101@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 10:53:30PM +0100, Jan Engelhardt wrote:
> >
> >Can anyone bring real life examples for this pretended harm?
> >
> >All examples I have heard until now fall under one of the following:
> >- CONFIG_MODULES=n wouldn't be worse
> >- if you want your kernel to fit on a floppy, CONFIG_UNIX shouldn't be 
> >  the thing making the difference between the kernel fitting on the
> >  floppy and the kernel not fitting on the floppy
> >
> Well, not directly topic'ed to CONFIG_UNIX, but if the IPv4 stack was modular
> (like IPv6), we'd probably gain some 100 KB and would not have to worry about
> CONFIG_UNIX for a while.

I doubt making the IPv4 stack modular is worth the trouble, but feel 
free to send a patch as a basis for a discussion...

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

