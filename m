Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269115AbRHIJ1C>; Thu, 9 Aug 2001 05:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269532AbRHIJ0w>; Thu, 9 Aug 2001 05:26:52 -0400
Received: from [193.120.224.170] ([193.120.224.170]:388 "EHLO florence.itg.ie")
	by vger.kernel.org with ESMTP id <S269115AbRHIJ0m>;
	Thu, 9 Aug 2001 05:26:42 -0400
Date: Thu, 9 Aug 2001 10:26:48 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Peter Osterlund <peter.osterlund@mailbox.swipnet.se>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kupdated oops in 2.4.8-pre5
In-Reply-To: <20010809103309.V4587@suse.de>
Message-ID: <Pine.LNX.4.33.0108090956290.13822-100000@dunlop.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Jens Axboe wrote:

> Double check your source, afaics it can't happen in pre7.

ah... sorry... you are right. the Oops would appear to be from -pre5.
I've had so many lockups this morning i lost track which kernel i was
running at what time.

however, there is a good chance that the fix has not worked, as the
trigger for the oops in pre5 is still consistently causing my box to
lockup with pre7 (but without oops).

The trigger is playing an mpeg movie with gtv, when i kill it.
sometimes it happens after the first play of a movie, sometimes the
2nd, 3rd. the box locks solid (with oops in pre5, without in
pre7). sysrq doesn't work. host doesn't respond to pings.

xine does not trigger the lockups. i've no idea what gtv does
differently to xine.

box is Compaq deskpro exd, i815 chipset, PIII 800, G200 graphics,
XFree 4.1.0, glibc 2.2.3.

anything you'd like to try?

--paulj


