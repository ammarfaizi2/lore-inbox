Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160218AbQHAQpl>; Tue, 1 Aug 2000 12:45:41 -0400
Received: by vger.rutgers.edu id <S160176AbQHAQoG>; Tue, 1 Aug 2000 12:44:06 -0400
Received: from [209.10.217.66] ([209.10.217.66]:3916 "EHLO neon-gw.transmeta.com") by vger.rutgers.edu with ESMTP id <S160160AbQHAQne>; Tue, 1 Aug 2000 12:43:34 -0400
To: linux-kernel@vger.rutgers.edu
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 1 Aug 2000 10:03:42 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8m6vte$es2$1@cesium.transmeta.com>
References: <7iw6kYsXw-B@khms.westfalen.de> <8m4q9v$871$1@enterprise.cistron.net> <8m4tn3$cri$1@cesium.transmeta.com> <20000731211810.B28169@thune.mrc-home.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: owner-linux-kernel@vger.rutgers.edu

Followup to:  <20000731211810.B28169@thune.mrc-home.org>
By author:    Mike Castle <dalgoda@ix.netcom.com>
In newsgroup: linux.dev.kernel
>
> On Mon, Jul 31, 2000 at 03:13:55PM -0700, H. Peter Anvin wrote:
> > Unfortunately that doesn't work very well.  For user-space daemons
> > which talk to Linux-specific kernel interfaces, such as automount, you
> > need both the glibc and the Linux kernel headers.
> 
> Does this mean that automount has to be rebuilt for every kernel?  And that
> we should be running /lib/modules/`uname -r`/sbin/automount.
> 

No, it doesn't.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
