Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131444AbQKSCMj>; Sat, 18 Nov 2000 21:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbQKSCM3>; Sat, 18 Nov 2000 21:12:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:52620 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131444AbQKSCMT>;
	Sat, 18 Nov 2000 21:12:19 -0500
Date: Sat, 18 Nov 2000 20:42:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
In-Reply-To: <20001119020829.A29947@athlon.random>
Message-ID: <Pine.GSO.4.21.0011182040160.21893-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2000, Andrea Arcangeli wrote:

> Good spotting but wrong fix.

<nod> s/32/31/ - forgot about the signedness. And yes, that should
go for both 2.2 and 2.4.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
