Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129670AbQKTBt5>; Sun, 19 Nov 2000 20:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129941AbQKTBts>; Sun, 19 Nov 2000 20:49:48 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:6148 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129851AbQKTBtk>; Sun, 19 Nov 2000 20:49:40 -0500
Date: Mon, 20 Nov 2000 01:16:23 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Dan Hollis <goemon@anime.net>
cc: Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <Pine.LNX.4.30.0011190740290.13294-100000@anime.net>
Message-ID: <Pine.LNX.4.30.0011200115070.1076-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, Dan Hollis wrote:

> Writeprotect the flashbios with the motherboard jumper, and remove the
> cmos battery.
>
> Checkmate. :-)

Only if you run your kernel XIP from the flash. If you load it into RAM,
it's still possible for an attacker to modify it. You can load new code
into the kernel even if the kernel doesn't make it easy for you by having
CONFIG_MODULES defined.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
