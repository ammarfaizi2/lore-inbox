Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbRASV6I>; Fri, 19 Jan 2001 16:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136689AbRASV5s>; Fri, 19 Jan 2001 16:57:48 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S136813AbRASV5j>;
	Fri, 19 Jan 2001 16:57:39 -0500
Date: Sat, 1 Jan 2000 02:10:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Ben Mansell <linux-kernel@slimyhorror.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
Message-ID: <20000101021033.B26@(none)>
In-Reply-To: <Pine.LNX.4.30.0101171454340.29536-100000@baphomet.bogo.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0101171454340.29536-100000@baphomet.bogo.bogus>; from linux-kernel@slimyhorror.com on Wed, Jan 17, 2001 at 03:02:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > And no, I don't actually hink that sendfile() is all that hot. It was
> > _very_ easy to implement, and can be considered a 5-minute hack to give
> > a feature that fit very well in the MM architecture, and that the Apache
> > folks had already been using on other architectures.
> 
> The current sendfile() has the limitation that it can't read data from
> a socket. Would it be another 5-minute hack to remove this limitation, so
> you could sendfile between sockets? Now _that_ would be sexy :)

I had patch to do that. (Unoptimized, of course)

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
