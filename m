Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290565AbSAYFSi>; Fri, 25 Jan 2002 00:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290567AbSAYFSS>; Fri, 25 Jan 2002 00:18:18 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:14792 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290565AbSAYFSQ>;
	Fri, 25 Jan 2002 00:18:16 -0500
Date: Fri, 25 Jan 2002 06:18:01 +0100
From: David Weinehall <tao@acc.umu.se>
To: Rik van Riel <riel@conectiva.com.br>
Cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020125061801.W1735@khan.acc.umu.se>
In-Reply-To: <20020124235608.C1096@earthlink.net> <Pine.LNX.4.33L.0201250256170.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0201250256170.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Jan 25, 2002 at 02:57:02AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 02:57:02AM -0200, Rik van Riel wrote:
> On Thu, 24 Jan 2002 rwhron@earthlink.net wrote:
> 
> > > workloads, I'm not sure I want to make the system more
> > > unfair just to better accomodate dbench ;)
> >
> > I'm wondering if rmap is a little too aggressive on
> > read-ahead, and if that has a negative impact on
> > a complex workload.
> 
> I haven't changed the readahead code one bit compared
> to 2.4 mainline, but I'm wondering the same.
> 
> Fixing readahead window sizing has been on my TODO list
> for quite a while already.

One thing that struck me about this; doesn't both the rmap-patches and
the aa-patches contain other changes than merely changes to the VM? If
so, couldn't these changes tip the result in an unfair direction?! After
all, what we want is a VM-to-VM shoot-out, not a VM-to-VM+whatever
shoot-out. After all, one would assume that the non VM-related changes
would be merged to the kernel no matter what VM is used, right?

Then again, maybe I just ate the blue pill and returned to a world of
illusions not knowing what's best for me.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
