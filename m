Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWCCNwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWCCNwH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 08:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWCCNwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 08:52:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1801 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751454AbWCCNwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 08:52:06 -0500
Date: Fri, 3 Mar 2006 14:52:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, dtor_core@ameritech.net,
       jgeorgas@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: make IPV4 modular (was: [2.6 patch] make UNIX a bool)
Message-ID: <20060303135202.GP9295@stusta.de>
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au> <20060302173840.GB9295@stusta.de> <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com> <20060302203245.GD9295@stusta.de> <9a8748490603021240t31f58ea4ycafae4ee8a12095c@mail.gmail.com> <20060302214055.GH9295@stusta.de> <Pine.LNX.4.61.0603022251270.13101@yvahk01.tjqt.qr> <20060302223218.GN9295@stusta.de> <Pine.LNX.4.61.0603031430280.2581@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603031430280.2581@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 02:31:04PM +0100, Jan Engelhardt wrote:
> >> Well, not directly topic'ed to CONFIG_UNIX, but if the IPv4 stack was modular
> >> (like IPv6), we'd probably gain some 100 KB and would not have to worry about
> >> CONFIG_UNIX for a while.
> >
> >I doubt making the IPv4 stack modular is worth the trouble, but feel 
> >free to send a patch as a basis for a discussion...
> >
> It would possibly require EXPORT_SYMBOLs, which you seem to be opposed to...

That's not the only point.

There are many cases you have to handle correctly. As a simple example,
CONFIG_W1=y, CONFIG_NET=m or CONFIG_W1=m, CONFIG_NET=m should compile as 
expected.

But hey, it's open source and much is possible. If you think this would 
be important send a patch and we have a basis for a discussion. 
Discussions about probable patches tend to become extremely fruitless.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

