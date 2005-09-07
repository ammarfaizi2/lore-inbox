Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVIGJVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVIGJVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 05:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVIGJVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 05:21:54 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:55438 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751116AbVIGJVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 05:21:54 -0400
Date: Wed, 7 Sep 2005 11:21:42 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Valdis.Kletnieks@vt.edu
Cc: Jesper Juhl <jesper.juhl@gmail.com>, "Budde, Marco" <budde@telos.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++ 
In-Reply-To: <200509070233.j872XcGh007159@turing-police.cc.vt.edu>
Message-Id: <Pine.OSF.4.05.10509071055180.21532-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2005 Valdis.Kletnieks@vt.edu wrote:

> On Wed, 07 Sep 2005 00:20:11 +0200, Esben Nielsen said:
> 
> > Which is too bad. You can do stuff much more elegant, effectively and
> > safer in C++ than in C. Yes, you can do inheritance in C, but it leaves
> > it up to the user to make sure the type-casts are done OK every time. You
> > can with macros do some dynamic typing, but not nearly as effectively as
> > with templates, and those macros always comes very, very ugly. (Some say
> > templates are ugly, but they first become ugly when they are used
> > way beyond what you can do with macros.)
> > 
> > I think it can only be a plus to Linux to add C++ support for at least
> > out-of-mainline drivers. Adding drivers written in C++ into the mainline
> > is another thing.
> 
> http://www.tux.org/lkml/#s15-3 Why don't we rewrite the Linux kernel in C++?
> 

I can't see it should be _that_ hard to make the kernel C++ friendly. At work 
I use a RTOS written in plain C but where you can easily use C++ in kernel
space (there is no user-space :-). We use gcc by the way.

It has been done for Linux as well 
(http://netlab.ru.is/pronto/pronto_code.shtml). Why can't this kind of
stuff be merged into the kernel? Why is there no efford to do so??
It is one of those projects I would have liked to spend time on if I had
any, but not if it would be rejected in the mainline no matter how little
intrusive it is. 

What I ague for is that people find out _what_ can be accepted in the
mainline with regard to C++. If the maintainers could somehow signal  
that a CONFIG_CPP_SUPPORT would be a acceptable option in the mainline
tree I am sure someone (not me out of lag of time) would make a patch and
submit it. I am sure distributions like RedHat would skip kernels with
CONFIG_CPP_SUPPORT=y once it was there.

Esben

PS. Do the above people break GPL by forcing people to accept a
license-agreement before downloading a patch to the kernel? Shouldn't they
provide a direct url?

