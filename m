Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTKIKba (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTKIKba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:31:30 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:12161 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262319AbTKIKb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:31:29 -0500
Date: Sun, 9 Nov 2003 10:33:41 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311091033.hA9AXfKT000886@81-2-122-30.bradfords.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, Matt <dirtbird@ntlworld.com>,
       herbert@gondor.apana.org.au,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031109100412.GA12868@ucw.cz>
References: <20031105173907.GA27922@ucw.cz>
 <Pine.LNX.4.44.0311050942461.11208-100000@home.osdl.org>
 <20031105180321.GC27922@ucw.cz>
 <20031109100412.GA12868@ucw.cz>
Subject: Re: [MOUSE] Alias for /dev/psaux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> XFree86 also sets the mouse to 200dpi

That's odd, I have a mouse which doesn't work correctly unless I
specifically add an Option "Resolution" "200" line to XF86Config.

Either the default isn't 200, or something else must be happening
differently when I set the resolution manually.

Without a resolution option at all, the mouse has to be moved at a
certain speed to register movement at all.  This has nothing to do
with accelleration, (which I don't use).  Moving the mouse slowly, for
any length of time, never produces any movement on-screen.  Moving it
quickly does.  With the resolution set to 200 or above, it works as
expected.  Lower than 200, and it exhibits the strange behavior.

The same thing happens with gpm.

(This behavior is observable with 2.4.  I haven't tested this mouse
with the in-kernel driver in 2.6 yet).

John.
