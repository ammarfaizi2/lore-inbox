Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUAESDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUAESDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:03:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:34533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265210AbUAESDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:03:52 -0500
Date: Mon, 5 Jan 2004 10:03:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       Daniel Jacobowitz <dan@debian.org>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <Pine.LNX.4.44.0401050944420.17134-100000@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0401050954280.2115@home.osdl.org>
References: <Pine.LNX.4.44.0401050944420.17134-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, Davide Libenzi wrote:
> 
> Vojtech, a spiral (in the math sense) won't work

It's not a spiral in that sense - it's just that the pattern you get when
walking the "dots" looks like a spiral.

> Also, IIRC, fractions are enumerable because they're a mapping from two
> enumerable spaces (integers): F = F(I1, I2) = I1 / I2.

Which is exactly the thing that Vojtech is really talking about: the
enumerable space of a _discrete_ two-dimensional shape, ie folding two
enumerable spaces onto one.

The negative values don't matter, since you can effectively enumerate both
ways starting from zero (ie the full set of integers is not any less
enumerable than the positive numbers are):

	0, 1, -1, 2, -2, 3, -3, ...

so it doesn't really matter if you only enumerate one quadrant (which is
effectively the same thing as enumerating fractions) or all four
quadrants.

The "spiral" pattern for a two-dimensional enumeration ends up being
something like

  (0,0) -> (1,0) -> (0,1) -> (-1,0) -> (0, -1) -> (1,-1) -> (2,0) -> ...

(do it on a graph paper and it's obvious, the above is probably wrong 
since I'm trying to visualize it)


		Linus
