Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160068AbQGaWAp>; Mon, 31 Jul 2000 18:00:45 -0400
Received: by vger.rutgers.edu id <S160133AbQGaV6k>; Mon, 31 Jul 2000 17:58:40 -0400
Received: from [209.10.217.66] ([209.10.217.66]:2430 "EHLO neon-gw.transmeta.com") by vger.rutgers.edu with ESMTP id <S160123AbQGaVyF>; Mon, 31 Jul 2000 17:54:05 -0400
To: linux-kernel@vger.rutgers.edu
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 31 Jul 2000 15:13:55 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8m4tn3$cri$1@cesium.transmeta.com>
References: <7iw6kYsXw-B@khms.westfalen.de> <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com> <8m4q9v$871$1@enterprise.cistron.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: owner-linux-kernel@vger.rutgers.edu

Followup to:  <8m4q9v$871$1@enterprise.cistron.net>
By author:    miquels@cistron.nl (Miquel van Smoorenburg)
In newsgroup: linux.dev.kernel
> 
> No. Even Linus himself has been saying for years (and recently even
> in this thread) that /usr/include/linux and /usr/include/asm should
> NOT EVER be symlinks to /usr/src/linux
> 
> Everything in /usr/include belongs to and depends on glibc, not
> the currently running kernel.
> 

Unfortunately that doesn't work very well.  For user-space daemons
which talk to Linux-specific kernel interfaces, such as automount, you
need both the glibc and the Linux kernel headers.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
