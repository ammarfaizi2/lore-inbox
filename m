Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129065AbRBKSOQ>; Sun, 11 Feb 2001 13:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129508AbRBKSOH>; Sun, 11 Feb 2001 13:14:07 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:17607 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129240AbRBKSNw>;
	Sun, 11 Feb 2001 13:13:52 -0500
Date: Sun, 11 Feb 2001 19:13:29 +0100
From: David Weinehall <tao@acc.umu.se>
To: Andriy Korud <akorud@polynet.lviv.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where are you going with 2.4.x?
Message-ID: <20010211191329.C20267@khan.acc.umu.se>
In-Reply-To: <E14S07t-0004Ty-00@the-village.bc.nu> <14711049588.20010211200148@polynet.lviv.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <14711049588.20010211200148@polynet.lviv.ua>; from akorud@polynet.lviv.ua on Sun, Feb 11, 2001 at 08:01:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 08:01:48PM +0200, Andriy Korud wrote:
> Alan> What is the oops data before the kernel panic. I need that to debug the
> Alan> driver. Also did you build the DAC960 support with gcc 2.96-x x<74 ?
> My system compiler is:
>    gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> Shoud I upgrade it to gcc 2.95.x or 2.96.x?
> 
> And since my last post 2.4.1-ac8 crashed again with:
>     kswapd: Cannot dereference NULL pointer.
> 
> On the next crash I'll try write down all traces.
> BTW, is there some way to log it somewhere to file?

Considering this is an enterprise-server, you should have a serial-console
to it; this will allow you to log all error-messages. Alternatively
(not as nice, though), is to connect a printer to the parallel-port and
use the parallelconsole option.

Then there's always the LKCD-patches, by SGI, if I'm not all wrong.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
