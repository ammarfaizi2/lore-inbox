Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160394AbQHBJIb>; Wed, 2 Aug 2000 05:08:31 -0400
Received: by vger.rutgers.edu id <S160368AbQHBJIW>; Wed, 2 Aug 2000 05:08:22 -0400
Received: from enterprise.cistron.net ([195.64.68.33]:4700 "EHLO enterprise.cistron.net") by vger.rutgers.edu with ESMTP id <S160309AbQHBJIK>; Wed, 2 Aug 2000 05:08:10 -0400
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: RLIM_INFINITY inconsistency between archs
Date: 2 Aug 2000 09:28:58 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8m8pkq$p1r$1@enterprise.cistron.net>
References: <7iw6kYsXw-B@khms.westfalen.de> <20000801023027.23228.qmail@t1.ctrl-c.liu.se> <20000801185531.B2091@thune.mrc-home.org> <8m7pci$fbt$1@cesium.transmeta.com>
X-Trace: enterprise.cistron.net 965208538 25659 195.64.65.200 (2 Aug 2000 09:28:58 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

In article >8m7pci$fbt$1@cesium.transmeta.com>,
H. Peter Anvin <hpa@zytor.com> wrote:
>Followup to:  <20000801185531.B2091@thune.mrc-home.org>
>By author:    Mike Castle <dalgoda@ix.netcom.com>
>In newsgroup: linux.dev.kernel
>> 
>> If they are so stable, then why does it matter which version of the kernel
>> glibc was built against and why aren't those kernel headers good enough to
>> accomplish what automounter needs?
>> 
>
>They usually are just fine.  However, if the automount protocol is
>updated, we don't want to *have* to sit through a full glibc release
>cycle.

It sounds like autofs should come with it's own copy of the
needed definitions and header files then. Now if there were 20
applications all using the autofs interface to the kernel then
it would be different, but if it's just one standard implementation..

Mike.
-- 
Cistron Certified Internetwork Expert #1. Think free speech; drink free beer.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
