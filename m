Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280631AbRKKTqK>; Sun, 11 Nov 2001 14:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280632AbRKKTqA>; Sun, 11 Nov 2001 14:46:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:245 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280631AbRKKTpv>;
	Sun, 11 Nov 2001 14:45:51 -0500
Date: Sun, 11 Nov 2001 14:45:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] long-living cache for block devices
In-Reply-To: <Pine.LNX.4.33.0111111126500.901-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111111444460.17411-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Nov 2001, Linus Torvalds wrote:

> Hmm.. Looking at "invalidate_bdev()", I doubt it matters, actually - it
> will already wait for all buffers, whether dirty or not. So it looks like
> it would already be impossible to have buffers on the queue.

Look at the last line of invalidate_bdev().

