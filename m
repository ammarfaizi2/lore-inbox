Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131016AbQKTDay>; Sun, 19 Nov 2000 22:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131169AbQKTDap>; Sun, 19 Nov 2000 22:30:45 -0500
Received: from anime.net ([63.172.78.150]:43535 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S131016AbQKTDai>;
	Sun, 19 Nov 2000 22:30:38 -0500
Date: Sun, 19 Nov 2000 19:00:41 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: David Woodhouse <dwmw2@infradead.org>
cc: Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <Pine.LNX.4.30.0011200115070.1076-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.30.0011191858180.18624-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2000, David Woodhouse wrote:
> On Sun, 19 Nov 2000, Dan Hollis wrote:
> > Writeprotect the flashbios with the motherboard jumper, and remove the
> > cmos battery.
> > Checkmate. :-)
> Only if you run your kernel XIP from the flash. If you load it into RAM,
> it's still possible for an attacker to modify it. You can load new code
> into the kernel even if the kernel doesn't make it easy for you by having
> CONFIG_MODULES defined.

The original assertion made was that a script kiddie could modify the
kernel so you wouldnt be able to detect a rooted box even after a reboot.

What I posted would stop that cold, 100%. Boot from writeprotected floppy,
writeprotect the flashbios, and remove the cmos battery.

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
