Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157315AbQHACBu>; Mon, 31 Jul 2000 22:01:50 -0400
Received: by vger.rutgers.edu id <S160060AbQHAB7k>; Mon, 31 Jul 2000 21:59:40 -0400
Received: from smtp.networkusa.net ([216.15.144.12]:9891 "EHLO smtp.networkusa.net") by vger.rutgers.edu with ESMTP id <S160088AbQHAB55>; Mon, 31 Jul 2000 21:57:57 -0400
Date: Mon, 31 Jul 2000 21:18:10 -0500
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Message-ID: <20000731211810.B28169@thune.mrc-home.org>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.rutgers.edu
References: <7iw6kYsXw-B@khms.westfalen.de> <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com> <8m4q9v$871$1@enterprise.cistron.net> <8m4tn3$cri$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
In-Reply-To: <8m4tn3$cri$1@cesium.transmeta.com>; from hpa@zytor.com on Mon, Jul 31, 2000 at 03:13:55PM -0700
Sender: owner-linux-kernel@vger.rutgers.edu

On Mon, Jul 31, 2000 at 03:13:55PM -0700, H. Peter Anvin wrote:
> Unfortunately that doesn't work very well.  For user-space daemons
> which talk to Linux-specific kernel interfaces, such as automount, you
> need both the glibc and the Linux kernel headers.

Does this mean that automount has to be rebuilt for every kernel?  And that
we should be running /lib/modules/`uname -r`/sbin/automount.

It's sounds like it's an awful lot like a loadable module in how tightly
it's tied to the kernel.  And how a kernel change can break things
horribly.  How you have to be built against the one you're going to run
against and not the one glibc was built against.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
