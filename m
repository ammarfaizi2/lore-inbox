Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbRAQOzd>; Wed, 17 Jan 2001 09:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131521AbRAQOzN>; Wed, 17 Jan 2001 09:55:13 -0500
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:50904 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S131488AbRAQOzK>; Wed, 17 Jan 2001 09:55:10 -0500
Date: Wed, 17 Jan 2001 15:02:02 +0000 (GMT)
From: Ben Mansell <linux-kernel@slimyhorror.com>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
Message-ID: <Pine.LNX.4.30.0101171454340.29536-100000@baphomet.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan 2001, Linus Torvalds wrote:

> And no, I don't actually hink that sendfile() is all that hot. It was
> _very_ easy to implement, and can be considered a 5-minute hack to give
> a feature that fit very well in the MM architecture, and that the Apache
> folks had already been using on other architectures.

The current sendfile() has the limitation that it can't read data from
a socket. Would it be another 5-minute hack to remove this limitation, so
you could sendfile between sockets? Now _that_ would be sexy :)


Ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
