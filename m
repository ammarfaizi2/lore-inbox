Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278518AbRJPEIf>; Tue, 16 Oct 2001 00:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278086AbRJPEIZ>; Tue, 16 Oct 2001 00:08:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6564 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278518AbRJPEIN>;
	Tue, 16 Oct 2001 00:08:13 -0400
Date: Tue, 16 Oct 2001 00:08:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] large /proc/mounts and friends
In-Reply-To: <Pine.LNX.4.33.0110152053080.8668-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110160005220.11608-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Linus Torvalds wrote:

> Ok, I'll re-read your patch with this in mind. But it sounds like I'm
> going to approve of it with this background...

Two points:
	a) seq_offs() and seq_unroll() are gone - they were rudiments of
earlier code;  not used and not needed in the variant I've sent.
	b) I've missed the check for pread() attempts.  Fixed.

PS: latency sucks...

