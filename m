Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135775AbREDTQf>; Fri, 4 May 2001 15:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135941AbREDTQZ>; Fri, 4 May 2001 15:16:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:55985 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135759AbREDTPU>;
	Fri, 4 May 2001 15:15:20 -0400
Date: Fri, 4 May 2001 15:15:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, volodya@mindspring.com,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <200105041849.f44InZa11520@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0105041504240.21896-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Richard Gooch wrote:

> > Two of them: use less bloated shell (and link it statically) and
> > clean your rc scripts.
> 
> No, because I'm not using the latest bloated version of bash, and I'm

Umm... Last version of bash I could call not bloated was _long_ time
ago. Something like ash(1) might be a better idea for /bin/sh.

> The problem is all the various daemons and system utilities (mount,
> hwclock, ifconfig and so on) that turn a kernel into a useful system.
> And then of course there's X...

How do you partition the thing? I.e. what's the size of your root partition?
I'm usually doing something from 10Mb to 30Mb - that may be the reason of
differences.

