Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272650AbRIGNYq>; Fri, 7 Sep 2001 09:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272652AbRIGNY3>; Fri, 7 Sep 2001 09:24:29 -0400
Received: from [195.89.159.99] ([195.89.159.99]:13301 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S272650AbRIGNYP>; Fri, 7 Sep 2001 09:24:15 -0400
Date: Fri, 7 Sep 2001 01:55:56 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Simon Hay <simon@haywired.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple monitors
Message-ID: <20010907015556.A7329@kushida.degree2.com>
In-Reply-To: <20010903214829.B17488@unthought.net> <Pine.LNX.4.33.0109032107280.2297-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109032107280.2297-100000@localhost.localdomain>; from simon@haywired.org on Mon, Sep 03, 2001 at 09:11:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Hay wrote:
> Also, though, on dedicated servers etc. I'd rather not be running X if
> I didn't have to.

You may find that a full screen xterm, with no window manager, actually
runs much faster than the console and looks identical.  It is certainly
the case on several of my machines.

This is most pronounced if X can do hardware acceleration on your video
card, although it is true even without acceleration because of xterm's
nice jump scroll capability.  (Btw, I prefer gnome-terminal because of
the Linux-console colour emulation :-).

On one 686 class machine, I saw text mode take nearly two seconds to
scroll the screen, when all but one line of the screen was being
scrolled (so it had to copy everything).  This was in pure text mode,
not even a framebuffer!  In X it was invisibly fast.

Also you may get a better refresh rate and higher resolution fonts out
of X, which is nice on a big display.

-- Jamie
