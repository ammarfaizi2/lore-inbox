Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160358AbQHAX7N>; Tue, 1 Aug 2000 19:59:13 -0400
Received: by vger.rutgers.edu id <S157250AbQHAX6z>; Tue, 1 Aug 2000 19:58:55 -0400
Received: from [209.10.217.66] ([209.10.217.66]:3752 "EHLO neon-gw.transmeta.com") by vger.rutgers.edu with ESMTP id <S160384AbQHAX56>; Tue, 1 Aug 2000 19:57:58 -0400
To: linux-kernel@vger.rutgers.edu
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 1 Aug 2000 17:18:26 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8m7pci$fbt$1@cesium.transmeta.com>
References: <7iw6kYsXw-B@khms.westfalen.de> <20000731211810.B28169@thune.mrc-home.org> <20000801023027.23228.qmail@t1.ctrl-c.liu.se> <20000801185531.B2091@thune.mrc-home.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: owner-linux-kernel@vger.rutgers.edu

Followup to:  <20000801185531.B2091@thune.mrc-home.org>
By author:    Mike Castle <dalgoda@ix.netcom.com>
In newsgroup: linux.dev.kernel
> 
> If they are so stable, then why does it matter which version of the kernel
> glibc was built against and why aren't those kernel headers good enough to
> accomplish what automounter needs?
> 

They usually are just fine.  However, if the automount protocol is
updated, we don't want to *have* to sit through a full glibc release
cycle.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
