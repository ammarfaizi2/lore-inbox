Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261982AbTCHBw5>; Fri, 7 Mar 2003 20:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbTCHBw5>; Fri, 7 Mar 2003 20:52:57 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:61125 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S261982AbTCHBw4>; Fri, 7 Mar 2003 20:52:56 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 7 Mar 2003 18:00:53 -0800 (PST)
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <Pine.LNX.4.44.0303080245350.32518-100000@serv>
Message-ID: <Pine.LNX.4.44.0303071753100.1933-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Mar 2003, Roman Zippel wrote:

> Hi,
>
> On Fri, 7 Mar 2003, David Lang wrote:
>
> > The reason he gave back when the discussion was first started (months ago)
> > was that klibc is designed to be directly linked into programs, and it was
> > felt that this would not be possible with the GPL. In fact klibc was
> > adopted instead of dietlibc speceificly BECOUSE of the license.
>
> There is still the possibility to support multiple libc implementation, if
> you don't like dietlibc, you're still free to use klibc.

along the same lines if you don't like klibc you are free to use or
implement dietlibc or anything else.

> > while you could add an additional clause to the GPL to allow it to be
> > linked into programs directly the I seriously doubt if the self appointed
> > 'GPL police' would notice the issue and would expect that fears on the
> > subject would limit it's use.
>
> Could we at least try to not let this degenerate into a flamewar? Thanks.

This was very much not intended to start a flamewar (and I do apologize if
anyone was offended by the post), but I think the very real fear of
oversealous GPL defenders is a large part of the reason why a modified GPL
was not chosen. The basic GPL was not chosen becouse the people
implementing klibc decided that the benifits of allowing propriatary code
outweighted the drawbacks as far as they are concerned.

I would love to see a lightweight libc that I could use for firewall
proxies and similar things that I have the source for but the license is
not GPL. The firewall toolkit proxies are an example, with libc5 I used to
put all the ones I used on a floppy to move them from one machine to
another, compiling with glibc there are some that won't fit on a floppy by
themselves, no functionality was gained in the process (and there is a
machine sitting under my desk that has a flash drive in it that I can't
use becouse they won't fit on it). it looks like klibc stands a good
chance of providing this.

David Lang
