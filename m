Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbRFANAr>; Fri, 1 Jun 2001 09:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263473AbRFANAh>; Fri, 1 Jun 2001 09:00:37 -0400
Received: from [130.239.18.139] ([130.239.18.139]:17099 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S263491AbRFANAY>;
	Fri, 1 Jun 2001 09:00:24 -0400
Date: Fri, 1 Jun 2001 14:59:00 +0200
From: David Weinehall <tao@acc.umu.se>
To: Phil Auld <pauld@egenera.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Configure.help is complete
Message-ID: <20010601145900.C12402@khan.acc.umu.se>
In-Reply-To: <Pine.GSO.4.21.0105311555250.17748-100000@weyl.math.psu.edu> <3B178E0E.A4530D47@egenera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3B178E0E.A4530D47@egenera.com>; from pauld@egenera.com on Fri, Jun 01, 2001 at 08:43:58AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2001 at 08:43:58AM -0400, Phil Auld wrote:
> Alexander Viro wrote:
> 
> ...snip...
> 
> > 
> > We should start removing the crap from procfs in 2.5. Documenting shit is
> > a good step, but taking it out would be better.
> > 
> 
> Not to open a what may be can of worms but ...
> 
> What's wrong with procfs? 

Imho, a procfs should be for process-information, nothing else.
The procfs in its current form, while useful, is something horrible
that should be taken out on the backyard and shot using slugs.

Ehrmmm. No, but seriously, the non-process stuff should be separate
from the procfs. Maybe call it kernfs or whatever.

> It allows a general interface to the kernel that does not require new
> syscalls/ioctls and can be accessed from user space without specifically
> compiled programs. You can use shell scripts, java, command line etc.

Yes, and it's also totally non standardised.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
