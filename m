Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132135AbRBKKmN>; Sun, 11 Feb 2001 05:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132133AbRBKKmD>; Sun, 11 Feb 2001 05:42:03 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130001AbRBKKlw>;
	Sun, 11 Feb 2001 05:41:52 -0500
Message-ID: <20010210222450.A7877@bug.ucw.cz>
Date: Sat, 10 Feb 2001 22:24:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ole Tange <tange@tange.dk>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: RAMDISK larger than 778000 KB halts system
In-Reply-To: <Pine.LNX.4.21.0102031518440.1830-100000@tigger.tange.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.21.0102031518440.1830-100000@tigger.tange.dk>; from Ole Tange on Sat, Feb 03, 2001 at 03:29:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [1.] One line summary of the problem:
>      Running badblocks on a ramdisk larger than 778000 KB halts
> system

Is it really bug?

You have 778000 KB of low ram, right? (That's the way himem patches
work, IIRC).

You have used all of it. You've run out of memory.

It might be pretty non-trivial to fix this.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
