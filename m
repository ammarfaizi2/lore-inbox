Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160370AbQHAXhA>; Tue, 1 Aug 2000 19:37:00 -0400
Received: by vger.rutgers.edu id <S160389AbQHAXgT>; Tue, 1 Aug 2000 19:36:19 -0400
Received: from smtp.networkusa.net ([216.15.144.12]:31640 "EHLO smtp.networkusa.net") by vger.rutgers.edu with ESMTP id <S157605AbQHAXe7>; Tue, 1 Aug 2000 19:34:59 -0400
Date: Tue, 1 Aug 2000 18:55:31 -0500
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Message-ID: <20000801185531.B2091@thune.mrc-home.org>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.rutgers.edu
References: <7iw6kYsXw-B@khms.westfalen.de> <Pine.LNX.3.95.1000731132321.529A-100000@chaos.analogic.com> <8m4q9v$871$1@enterprise.cistron.net> <8m4tn3$cri$1@cesium.transmeta.com> <20000731211810.B28169@thune.mrc-home.org> <20000801023027.23228.qmail@t1.ctrl-c.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
In-Reply-To: <20000801023027.23228.qmail@t1.ctrl-c.liu.se>; from wingel@t1.ctrl-c.liu.se on Tue, Aug 01, 2000 at 02:30:27AM -0000
Sender: owner-linux-kernel@vger.rutgers.edu

On Tue, Aug 01, 2000 at 02:30:27AM -0000, wingel@t1.ctrl-c.liu.se wrote:
> In article <20000731211810.B28169@thune.mrc-home.org> dalgoda@ix.netcom.com wrote:
> >On Mon, Jul 31, 2000 at 03:13:55PM -0700, H. Peter Anvin wrote:

[hpa talks about apps, like automount, needing kernel headers for versions 
being ran and version glibc was built againt]

[I ask about kernel specific versions of binaries]

> It only means that the application will be built agains the kernel 
> _interface_ that was present in that version of the kernel.  And 
> syscall/ioctl interfaces should never change, they can be added to,
> and relly old depreciated interfaces can be removed, but they should
> be stable for at least a few major kernel releases.

If they are so stable, then why does it matter which version of the kernel
glibc was built against and why aren't those kernel headers good enough to
accomplish what automounter needs?

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
