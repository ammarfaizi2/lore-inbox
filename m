Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131160AbRAAXQA>; Mon, 1 Jan 2001 18:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131544AbRAAXPv>; Mon, 1 Jan 2001 18:15:51 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:57356 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S131160AbRAAXPt>;
	Mon, 1 Jan 2001 18:15:49 -0500
Date: Tue, 2 Jan 2001 00:45:18 +0200 (SAST)
From: Hans Grobler <grobh@sun.ac.za>
To: f5ibh <f5ibh@db0bm.ampr.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-prerelease, AX25 problems
In-Reply-To: <200101012228.XAA03423@db0bm.ampr.org>
Message-ID: <Pine.LNX.4.30.0101020030570.30708-100000@prime.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Luc,

On Mon, 1 Jan 2001, f5ibh wrote:
> You wrote :
> > Is the "previous test version" you talk about 2.4.0-test13-pre7?  There
> > weren't any changes since then that could explain this, except maybe:
> Yes, I mean test13-pre[12134567] and other older versions too.
> I've already had the problem some time ago with an older 2.4.0-testxx kernel.
> I don't think it is directly related to the ax25 stuff but maybe (?) a timer
> modified elsewhere ?

Ok, so the problem lies deeper. Could you take a guess at the version that
worked (say 2.2.17?) and the first one that stopped working (say 2.4.0-test1?)...
Once we have a rough range, I'll see if I can find anything.

Also: I assume you have PROC_FS compiled. What does /proc/net/z8530drv
contain before and after the failed packet TX attempt?

And: Can you receive any packets?

-- Hans






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
