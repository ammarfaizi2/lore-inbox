Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160853AbQHDAqi>; Thu, 3 Aug 2000 20:46:38 -0400
Received: by vger.rutgers.edu id <S160765AbQHDAq2>; Thu, 3 Aug 2000 20:46:28 -0400
Received: from [209.10.217.66] ([209.10.217.66]:2943 "EHLO neon-gw.transmeta.com") by vger.rutgers.edu with ESMTP id <S157527AbQHDAqN>; Thu, 3 Aug 2000 20:46:13 -0400
To: linux-kernel@vger.rutgers.edu
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 3 Aug 2000 18:07:34 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8md50m$jfs$1@cesium.transmeta.com>
References: <7iw6kYsXw-B@khms.westfalen.de> <20000801185531.B2091@thune.mrc-home.org> <8m7pci$fbt$1@cesium.transmeta.com> <8m8pkq$p1r$1@enterprise.cistron.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: owner-linux-kernel@vger.rutgers.edu

Followup to:  <8m8pkq$p1r$1@enterprise.cistron.net>
By author:    miquels@cistron.nl (Miquel van Smoorenburg)
In newsgroup: linux.dev.kernel
> >
> >They usually are just fine.  However, if the automount protocol is
> >updated, we don't want to *have* to sit through a full glibc release
> >cycle.
> 
> It sounds like autofs should come with it's own copy of the
> needed definitions and header files then. Now if there were 20
> applications all using the autofs interface to the kernel then
> it would be different, but if it's just one standard implementation..
> 

Two, at least (amd uses it as well, now.)  There are a number of
similar interface issues, though, and the fact remains this is at best
an ad hoc solution.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
