Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280961AbRLSSKE>; Wed, 19 Dec 2001 13:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280971AbRLSSJy>; Wed, 19 Dec 2001 13:09:54 -0500
Received: from donna.siteprotect.com ([64.41.120.44]:28177 "EHLO
	donna.siteprotect.com") by vger.kernel.org with ESMTP
	id <S280961AbRLSSJs>; Wed, 19 Dec 2001 13:09:48 -0500
Date: Wed, 19 Dec 2001 13:09:34 -0500 (EST)
From: John Clemens <john@deater.net>
X-X-Sender: <john@pianoman.cluster.toy>
To: "Martin A. Brooks" <martin@jtrix.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: asynchronus multiprocessing
In-Reply-To: <1008777560.431.19.camel@unhygienix>
Message-ID: <Pine.LNX.4.33.0112191303420.10093-100000@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I looked into this a little while ago... never got a patch working
100% correctly...there was some discussions about it on the SGI Linux
Scalability list (as far as i can tell, it was the -only- discussion on
the SGI list, as the IBM list started about the same time.. ahhh, orphaned
mailing lists..).. It was a quick-n-dirty hack, and only the beginnings of
one at that...

i put a quick page up about it at
http://www.deater.net/john/processorgroups.html

Conclusion: Could be done, not worth it for miniscule speed gains, could
be much more of a benefit on NUMA machines, but the linux scalable
scheduler's out there are probably a much better approach to doing the
same thing...

john.c

On 19 Dec 2001, Martin A. Brooks wrote:

> On Wed, 2001-12-19 at 15:40, Martin A. Brooks wrote:
> > Has there been any talk of (or work on) AMP support in the kernel?
>
> I meant /asymmetric/ MP. Sorry.
>
>

-- 
John Clemens          http://www.deater.net/john
john@deater.net     ICQ: 7175925, IM: PianoManO8
      "I Hate Quotes" -- Samuel L. Clemens


