Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130105AbRBZBjj>; Sun, 25 Feb 2001 20:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbRBZBja>; Sun, 25 Feb 2001 20:39:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:17133 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130105AbRBZBjX>;
	Sun, 25 Feb 2001 20:39:23 -0500
Date: Sun, 25 Feb 2001 20:39:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: Werner.Almesberger@epfl.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <UTC200102260114.CAA10722.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0102252022540.26808-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Feb 2001 Andries.Brouwer@cwi.nl wrote:

> > BTW, we probably want to add mount --move <old> <new> - atomically moving
> > a subtree from one place to another. Code is there, we just need to
> > decide on API. Andries?
> 
> Since we already have "mount --bind olddir newdir" this is not
> an unreasonable extension of the mount(8) syntax.
> And since the kernel is no longer so interested in coeds as
> some former mount author, we have lots of free bits.

/me scratches head and tries to figure out waht does "coed" mean...
<looking into webster>
C|N>K
<adding l-k to the "don't drink coffee while reading that" list>

> There are even old bits.
> 
> #define MS_MOVE	0x2000

Works for me...
							Cheers,
								Al

