Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135556AbRDXMEk>; Tue, 24 Apr 2001 08:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135559AbRDXMEa>; Tue, 24 Apr 2001 08:04:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6276 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135556AbRDXMEZ>;
	Tue, 24 Apr 2001 08:04:25 -0400
Date: Tue, 24 Apr 2001 08:04:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: imel96@trustix.co.id
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104241830020.11899-100000@tessy.trustix.co.id>
Message-ID: <Pine.GSO.4.21.0104240752320.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001 imel96@trustix.co.id wrote:

> a friend of my asked me on how to make linux easier to use
> for personal/casual win user.
> 
> i found out that one of the big problem with linux and most
> other operating system is the multi-user thing.

What, makes it hard to write viruses for it? Awww, poor skr1pt k1dd13z...

> i think, no personal computer user should know about what's
> an operating system idea of a user. they just want to use
> the computer, that's it.

And would that "use" by any chance include access to network?

> by a personal computer i mean home pc, notebook, tablet,
> pda, and communicator. only one user will use those devices,
> or maybe his/her friend/family. do you think that user want
> to know about user account?

So let him log in as root, do everything as root and be cracked
like a bloody moron he is. Next?

> from that, i also found out that it is very awkward to type
> username and password every time i use my computer.

So break your /sbin/login.

> so here's a patch. i also have removed the user_struct from
> my kernel, but i don't think you'd like #ifdef's.
> may be it'll be good for midori too.

[snip the patch that makes all user ids equivalent to root, but
doesn't remove networking support]

What for? If they want root - give them root and be done with that.
No need to change the kernel.

You know, if you really do not understand the implications of
running everything with permissions equivalent to root - get
the hell out of any UNIX-related programming until you learn.

If you want CP/M or MacOS - you know where to find them.

