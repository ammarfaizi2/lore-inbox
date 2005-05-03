Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVECK5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVECK5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 06:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVECK5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 06:57:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52488 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261453AbVECK5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 06:57:47 -0400
Date: Tue, 3 May 2005 12:57:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig files (first part)
Message-ID: <20050503105743.GE3592@stusta.de>
References: <20050503003400.GO3592@stusta.de> <Pine.LNX.4.61.0505031107120.996@scrub.home> <20050503092202.GC3592@stusta.de> <Pine.LNX.4.61.0505031202080.996@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505031202080.996@scrub.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 12:09:37PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Tue, 3 May 2005, Adrian Bunk wrote:
> 
> > The separator used for the help is to indent help texts by two 
> > additional spaces.
> 
> Yes, that's an additional indicator.
> 
> > IMHO, Kconfig files are quite readable due to this indentation even 
> > though only a minority of the entries was using "---help---" even 
> > before this patch.
> 
> So why exactly has to be removed? Is it ugly? Does it make Kconfig worse?

The ugly thing is that there are currently two different ways to express 
the same thing. It only causes confusion for people who think those 
different syntaxes had a different meaning.

> Sorry, but only because it's not used that often, is not enough of a 
> reason for me to remove it. If it helps only a little bit to spot the help 
> text start easier, it's IMO worth to keep it.

Do you or does anyone else have a problem with spotting the help text 
start with "only" two additional spaces indentation?

If it's only for Aunt Tillie it's not required.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

