Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVEaAla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVEaAla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVEaAla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:41:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5137 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261847AbVEaAlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:41:25 -0400
Date: Tue, 31 May 2005 02:41:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig files (first part) (fwd)
Message-ID: <20050531004120.GH3627@stusta.de>
References: <20050531001038.GD3627@stusta.de> <Pine.LNX.4.61.0505310217030.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505310217030.3728@scrub.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 02:17:50AM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Tue, 31 May 2005, Adrian Bunk wrote:
> 
> > The main reason for this patch (quoting Jesper) is:
> >   Consistency. out of ~4000 help entries in 134 Kconfig files, 747 of 
> >   those entries use "---help---" as the keyword, the rest use just "help". 
> >   So the users of "---help---" are clearly a minority and by renaming them 
> >   we make things consistent. - I hate inconsistency. :-)
> 
> And I still don't like this change...

there's still the point that it's currently used inconsistently.

If you really prefer "---help---" over "help" (I consider "help" being 
better, but as long as it's used consistently each of them is 
acceptable), feel free to send a patch instead that changes all
occurences of "help" to "---help---".

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

