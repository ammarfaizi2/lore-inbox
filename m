Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276914AbRKFBeQ>; Mon, 5 Nov 2001 20:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276982AbRKFBeG>; Mon, 5 Nov 2001 20:34:06 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:49871 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276914AbRKFBdu>;
	Mon, 5 Nov 2001 20:33:50 -0500
Date: Mon, 5 Nov 2001 20:33:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.LNX.4.33.0111051557520.1059-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111052029260.27086-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Linus Torvalds wrote:

> For example, spreading out (and the inherent assumption of "slow growth")
> might make sense for the root directory, and possibly for a level below
> that. It almost certainly does _not_ make sense for a directory created
> four levels down.

Depends on the naming scheme used by admin, for one thing.  Linus, I seriously
think that getting the real-life traces to play with would be a Good Thing(tm)
- at least that would allow to test how well would heuristics of that kind do.

