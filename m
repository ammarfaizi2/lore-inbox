Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314035AbSEAUVL>; Wed, 1 May 2002 16:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314043AbSEAUVK>; Wed, 1 May 2002 16:21:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21011 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314035AbSEAUVJ>; Wed, 1 May 2002 16:21:09 -0400
Date: Wed, 1 May 2002 22:21:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] TRIVIAL 2.5.12 WP security warning
Message-ID: <20020501202110.GD31317@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E172oSp-0007ot-00@wagner.rustcorp.com.au> <20020501133325.G29327@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > Pavel Machek <pavel@ucw.cz>: Warn users about machines with non-working WP bit:
>  >   Hi!
>  >   
>  >   This might be good idea, as those machines are not safe for multiuser
>  >   systems.
>  >   
>  > -		printk("No.\n");
>  > +		printk("No (that's security hole).\n");
>  >  #ifdef CONFIG_X86_WP_WORKS_OK
> 
> Maybe be a little more explicit in the wording ?
> 
> "No. This system is insecure in a multiuser environment.\n" perhaps ?

Looks good.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
