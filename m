Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSDUEF3>; Sun, 21 Apr 2002 00:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293510AbSDUEF3>; Sun, 21 Apr 2002 00:05:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:56513 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293337AbSDUEF2>;
	Sun, 21 Apr 2002 00:05:28 -0400
Date: Sun, 21 Apr 2002 00:05:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
Subject: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org>
Message-ID: <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Apr 2002, Ian Molton wrote:

> is this 'bitkeeper documentation', 'documentation about bitkeeper', or
> 'linux kernel documentation', or what?

"Linus documentation".

/me carefully stays the hell away from discussing whether it's a part of
documented object or not and what would be the license on said object...

As one of the guys who doesn't use BK _and_ had submitted a lot of patches
since Linus had started using it, I'm probably qualified to tell whether it
hurts or not, right?  Well, it doesn't.  So far the only difference was
in the quality (and latency) of changelogs and that was definitely welcome.

As long as "I've got a bunch of patches affecting <area>. Seeing that you've
merged stuff touching <area> since the last -pre, resync point would be
a Good Thing(tm)" works I couldn't care less about BK vs. diff+mail.  So
far it seems to be working fine.

FWIW, I doubt that dropping -pre completely in favour of dayly snapshots is
a good idea - "2.5.N-preM oopses when ..." is preferable to "snapshot YY/MM/DD
oopses when..." simply because it's easier to match bug reports that way.
Having all deltas downloadable as diff+comment is wonderful, but it doesn't
replace well-defined (and less frequent) resync points.

Comments?

