Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVCBXRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVCBXRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCBXOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:14:21 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5394 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261320AbVCBXMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:12:43 -0500
Date: Thu, 3 Mar 2005 00:12:31 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050302231231.GA30106@alpha.home.local>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

For a long time, I've been hoping/asking for a more frequent stable/unstable
cycle, so clearly you can count my vote on this one (eventhough it might
count for close to zero). This is a very good step towards a better stability
IMHO.

However, I have a comment :

>  - 2.6.<odd>: still a stable kernel, but accept bigger changes leading up 
>    to it (timeframe: a month or two).
>  - 2.<odd>.x: aim for big changes that may destabilize the kernel for 
>    several releases (timeframe: a year or two)
>  - <odd>.x.x: Linus went crazy, broke absolutely _everything_, and rewrote
>    the kernel to be a microkernel using a special message-passing version 
>    of Visual Basic. (timeframe: "we expect that he will be released from 
>    the mental institution in a decade or two").

I don't agree with you on this last one (not the fact that you don't want
an mk+mp+vb combination :-)). The VERSION number (in the makefile meaning of
the term) only gets updated every 10 years or so. So it does not need to
jump. PATCHLEVEL increments are rare enough to justify lots of breaking.
I certainly can imagine people laughing at your OS when you jump from v2.6.X
to v4.0.X, it will have a smell of slowaris (remember 2.6 - 2.7 - 7 - 8 that
confused everyone ?). On the other side, the openbsd numbering scheme is far
simpler to understand, and I sincerely think that we should enter 3.0 after
2.8. As a side note, I've always wondered why we would not swap odds and
evens, so that we can keep the same major number between devel and release
(eg: devel 2.8, release 2.9 ; not devel 2.9, release 3.0). Anyway, people
have got used to stay away from the '.0' releases of any product on the
planet.

Regards
Willy

