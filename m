Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRAVHey>; Mon, 22 Jan 2001 02:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbRAVHee>; Mon, 22 Jan 2001 02:34:34 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:41990 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129842AbRAVHeX>; Mon, 22 Jan 2001 02:34:23 -0500
Date: Mon, 22 Jan 2001 07:34:09 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Rainer Mager <rmager@vgkk.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is this kernel related (signal 11)?
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGOEJOCNAA.rmager@vgkk.com>
Message-ID: <Pine.LNX.4.30.0101220725550.8352-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001, Rainer Mager wrote:

> 	I brought up this issue last month and had some response but as
> of yet my particular problem still exists. In brief, X windows dies
> with signal 11. I have done quite a bit of testing and this does not
> seem to be a hardware issue. Also, I have never managed to get a
> signal 11 error when not running X.

Would this be an SMP IA32 box with glibc 2.2? I have two such boxen 
showing exactly the same behaviour, although I can't reproduce it at will.

It happens even when I use the same kernel and XFree86 binaries which were
working perfectly before the upgrade. The LDT handling fixes which were
added between 2.4.0-prerelease and the real 2.4.0 appeared to make this
_slightly_ less frequent, but I still rarely have an X server uptime of
more than a few days.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
