Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129492AbRBCLkf>; Sat, 3 Feb 2001 06:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129508AbRBCLkZ>; Sat, 3 Feb 2001 06:40:25 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:8715 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129492AbRBCLkP>; Sat, 3 Feb 2001 06:40:15 -0500
Date: Sat, 3 Feb 2001 11:39:58 +0000 (GMT)
From: <linkern@cocoa.demon.co.uk>
Reply-To: linkern@cocoa.demon.co.uk
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.2.x->2.4.x API Changes (superblock.notify_change()...)
Message-ID: <Pine.LNX.4.21.0102031056120.5670-100000@cocoa.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

I've been away for a little while, but now that I've upgraded from kernel
2.2 to 2.4, I'm trying to port some modules that I use, without much luck
as a fair amount of stuff has changed!

Some functions/structure members that I'm currently drawing a blank when
looking for equivalents in 2.4 are:

superblock.notify_change
  (*is* there an equivalent any more?)

namei()/__namei()
  (arrrgh! there were one or two vfs changes in 2.4, weren't there?! :)

start_bh_atomic()/end_bh_atomic()

Can anyone give me equivalents for these under 2.4, or better, a pointer to
a page (or pages :) that describes the API changes in depth?

That's about all for now as it's hard to work out what's causing the rest of
the errors... :)

Cheers,
Alex.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
