Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbQKAPBX>; Wed, 1 Nov 2000 10:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130119AbQKAPBO>; Wed, 1 Nov 2000 10:01:14 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:563 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130100AbQKAPBB>; Wed, 1 Nov 2000 10:01:01 -0500
Date: Wed, 1 Nov 2000 16:00:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, Larry McVoy <lm@bitmover.com>,
        Paul Menage <pmenage@ensim.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001101160008.C9774@athlon.random>
In-Reply-To: <20001101023010.G13422@athlon.random> <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org> <20001101023010.G13422@athlon.random> <15012.973077196@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15012.973077196@redhat.com>; from dwmw2@infradead.org on Wed, Nov 01, 2000 at 11:13:16AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 11:13:16AM +0000, David Woodhouse wrote:
> Isn't that _exactly_ what happens with Linux kernel threads, with lazy mm 
> switching?

Sure. Infact all the kernel (modules included) runs in ring 0 sharing the same
part of VM and - as everybody knows - a bug in a driver (or in khttpd or tux)
can crash the kernel.

But you can't destabilize the whole system when a bug in apache triggers (that
would happen with a ring 0 linux instead, and yes, with "linux" Jeff meant the
whole system, not just the kernel).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
