Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLGWqf>; Thu, 7 Dec 2000 17:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbQLGWq0>; Thu, 7 Dec 2000 17:46:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5295 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129289AbQLGWqR>;
	Thu, 7 Dec 2000 17:46:17 -0500
Date: Thu, 7 Dec 2000 17:15:48 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries Brouwer <aeb@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <20001207171616.B23858@veritas.com>
Message-ID: <Pine.GSO.4.21.0012071138430.22281-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2000, Andries Brouwer wrote:

> On Thu, Dec 07, 2000 at 10:24:31AM -0500, Alexander Viro wrote:
> 
> > Al, currently walking through the /usr/share/man/man2 and swearing silently...
> 
> Swearing? At the POSIX decisions or at the man page quality?

Mostly at the out-of-sync/not-all-errors-documented kind of places and amount
of fun involved in getting them in sync with the tree (and with each other,
for that matter). Oh, well...

> In the latter case, additions and corrections are very welcome.
> Make sure that you have 1.31 installed. 

Grabbed it. BTW, if you still have 1.7, 1.10, 1.13 and 1.14...  I've managed
to dig the rest out, but these seem to be gone (looks like a modified 1.10
is out there, but...)

I was thinking about putting the whole bunch under the CVS.  If you have
the missing ones somewhere and could send an URL...

BTW, could we finally lose mpx(2)? Very few programs used it under v7 and
that experiment had been abandoned early in 80s, so it's not like we needed
it for porting. phys(2) is already gone (not from unimplemented(2), though),
so we have a precedent of removing such stuff.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
