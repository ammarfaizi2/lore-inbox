Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVBYVPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVBYVPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVBYVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:15:00 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18441 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261423AbVBYVO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:14:57 -0500
Date: Fri, 25 Feb 2005 22:14:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050225211453.GC3311@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org> <20050224215136.GK8651@stusta.de> <20050224224134.GE20715@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224224134.GE20715@opteron.random>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 11:41:34PM +0100, Andrea Arcangeli wrote:

> Hello Adrian,

Hi Andrea,

> On Thu, Feb 24, 2005 at 10:51:36PM +0100, Adrian Bunk wrote:
> > seccomp might be a nice feature under some circumstances.
> > But the suggestion in the help text is IMHO too strong and therefore 
> > removed by this patch.
> 
> Why too strong? The reason there is a config option is for the embedded
> space, where clearly they want to compile into the kernel only the
> strict features they use.
> 
> There are no risks in enabling seccomp and the size of the kernel image
> won't change in any significant way either.
> 
> So I'd prefer to keep the "If unsure, say Y." and it seems appropriate
> to me.
> 
> You have to say Y, if later on you want to sell your CPU resources with
> Cpushare.  BTW, you can already test it if you download version 0.8 of
> the LGPL'd Cpushare software, it'll connect to the server and it'll
> execute a remote seccomp computation and then it'll hang around until
> you stop it with ./stop_cpushare.sh (and you will see your client
> connected in the homepage stats). I didn't finish writing all the code
> yet but it's already a decent demo for the seccomp part at least.
>...

this sounds more like an "If unsure, say N.":
You don't need this feature unless you know you need it.

It's not about risk or the actual size of the code - there are many 
small or big features in the kernel that might be useful under some 
circumstances, but even the IPv6 help text still suggests to say N
to IPv6.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

