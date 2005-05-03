Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVECJWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVECJWR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 05:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVECJWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 05:22:16 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47623 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261427AbVECJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 05:22:11 -0400
Date: Tue, 3 May 2005 11:22:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig files (first part)
Message-ID: <20050503092202.GC3592@stusta.de>
References: <20050503003400.GO3592@stusta.de> <Pine.LNX.4.61.0505031107120.996@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505031107120.996@scrub.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 11:10:48AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Tue, 3 May 2005, Adrian Bunk wrote:
> 
> > This patch is the majority of a patch by Jesper Juhl.
> > 
> > This patch renames all instances of "---help---" to simply "help" in all 
> > of the Kconfig files.
> > 
> > The main reason for this patch (quoting Jesper) is:
> > 
> > Consistency. out of ~4000 help entries in 134 Kconfig files, 747 of 
> > those entries use "---help---" as the keyword, the rest use just "help". 
> > So the users of "---help---" are clearly a minority and by renaming them 
> > we make things consistent. - I hate inconsistency. :-)
> 
> This has nothing to do with consistency but with readability.
> This was introduced to better separate the help in large menu entries. In 
> order to accept this patch, I would either like hear reasons, why this 
> isn't needed anymore or I'd like to see an alternative, more consistent 
> separator.

The separator used for the help is to indent help texts by two 
additional spaces.

IMHO, Kconfig files are quite readable due to this indentation even 
though only a minority of the entries was using "---help---" even 
before this patch.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

