Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130540AbRACXDI>; Wed, 3 Jan 2001 18:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRACXC6>; Wed, 3 Jan 2001 18:02:58 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11676 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130551AbRACXCy>;
	Wed, 3 Jan 2001 18:02:54 -0500
Date: Wed, 3 Jan 2001 18:02:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dan Aloni <karrde@callisto.yi.org>
cc: Dan Hollis <goemon@anime.net>, linux-kernel <linux-kernel@vger.kernel.org>,
        mark@itsolve.co.uk
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking
 bug exploits
In-Reply-To: <Pine.LNX.4.21.0101040037200.21774-100000@callisto.yi.org>
Message-ID: <Pine.GSO.4.21.0101031750070.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Dan Aloni wrote:

> Did you notice that question was ambiguous? I understood that sentence in
> its other meaning, i.e, someone insulting Alex ;-)

<choke><sputter> Well, _that_ definitely takes more than posting a patch ;-)

> Anyway, while it is agreed that you can't completely eliminate exploits,
> it is recommended that, it should be at least harder to create them, maybe
> it can even minimize the will to write them.

<shrug> large overhead to every syscall and protection that can be defeated
in a couple of instructions. Doesn't look like a good tradeoff.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
