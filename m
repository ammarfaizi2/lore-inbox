Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTKIKjO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTKIKjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:39:14 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:4749 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262324AbTKIKjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:39:13 -0500
Date: Sun, 9 Nov 2003 11:38:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Matt <dirtbird@ntlworld.com>, herbert@gondor.apana.org.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [MOUSE] Alias for /dev/psaux
Message-ID: <20031109103853.GA13154@ucw.cz>
References: <20031105173907.GA27922@ucw.cz> <Pine.LNX.4.44.0311050942461.11208-100000@home.osdl.org> <20031105180321.GC27922@ucw.cz> <20031109100412.GA12868@ucw.cz> <200311091033.hA9AXfKT000886@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311091033.hA9AXfKT000886@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 10:33:41AM +0000, John Bradford wrote:
> > XFree86 also sets the mouse to 200dpi
> 
> That's odd, I have a mouse which doesn't work correctly unless I
> specifically add an Option "Resolution" "200" line to XF86Config.

This has changed between the versions of XFree86. Older versions used a
value of 100 which is the PS/2 default. Because of mice which give
trouble when they don't get a 200, like yours, this was changed in the
recent version(s).

> Either the default isn't 200, or something else must be happening
> differently when I set the resolution manually.
> 
> Without a resolution option at all, the mouse has to be moved at a
> certain speed to register movement at all.  This has nothing to do
> with accelleration, (which I don't use).  Moving the mouse slowly, for
> any length of time, never produces any movement on-screen.  Moving it
> quickly does.  With the resolution set to 200 or above, it works as
> expected.  Lower than 200, and it exhibits the strange behavior.
> 
> The same thing happens with gpm.
> 
> (This behavior is observable with 2.4.  I haven't tested this mouse
> with the in-kernel driver in 2.6 yet).

Please test, but after you apply the patch.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
