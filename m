Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130830AbQKBASI>; Wed, 1 Nov 2000 19:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131047AbQKBAR6>; Wed, 1 Nov 2000 19:17:58 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:34571 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S130830AbQKBARz>; Wed, 1 Nov 2000 19:17:55 -0500
From: miquels@cistron.nl (Miquel van Smoorenburg)
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Date: 2 Nov 2000 00:17:57 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <8tqbrl$q59$1@enterprise.cistron.net>
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net>
X-Trace: enterprise.cistron.net 973124277 26793 195.64.65.201 (2 Nov 2000 00:17:57 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200011012247.OAA19546@pizda.ninka.net>,
David S. Miller <davem@redhat.com> wrote:
>   Date: 	Wed, 1 Nov 2000 23:57:34 +0100
>   From: Kurt Garloff <garloff@suse.de>
>
>   kgcc is a redhat'ism.
>
>Debian has it too.

Not quite. Debian does have an completely optional gcc272 package. It
is _not_ installed as kgcc (the binary is called gcc272) and you don't
_have_ to compile your kernels with it. It is an optional package and
you have to actively select and install it. By default Debian comes
with gcc 2.95.2 which compiles current 2.2.x and 2.4.x kernels just
fine. At least I haven't used gcc272 for kernels for at least a year now
(I think, first egcs, then gcc 2.95) and on all the servers I administer
(and that's quite a few) gcc 2.95 hasn't caused any problems.

Mike.
-- 
People get the operating system they deserve.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
