Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129205AbQKTUll>; Mon, 20 Nov 2000 15:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129213AbQKTUlV>; Mon, 20 Nov 2000 15:41:21 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:55999 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129205AbQKTUlK>; Mon, 20 Nov 2000 15:41:10 -0500
Date: Mon, 20 Nov 2000 20:33:25 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: "Charles Turner, Ph.D." <cturner@quark.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Defective Red Hat Distribution poorly represents Linux
Message-ID: <20001120203325.A14918@iapetus.localdomain>
In-Reply-To: <Pine.LNX.3.95.1001120084920.580A-100000@quark.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.3.95.1001120084920.580A-100000@quark.analogic.com>; from cturner@quark.analogic.com on Mon, Nov 20, 2000 at 08:53:19AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 08:53:19AM -0500, Charles Turner, Ph.D. wrote:
> [root@merrimac linux-2.2.17]# make dep
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o scripts/mkdep scripts/mkdep.c
> collect2: ld terminated with signal 11 [Segmentation fault], core dumped
> make: *** [scripts/mkdep] Error 1
[...]
> [root@merrimac linux-2.2.17]# cd scripts
> [root@merrimac scripts]# gcc -o mkdep.o mkdep.c
> collect2: ld terminated with signal 11 [Segmentation fault], core dumped
> [root@merrimac scripts]# gcc -c -o mkdep.o mkdep.c
> [root@merrimac scripts]# ld -o mkdep mkdep.o
> Segmentation fault (core dumped)
This _is_ a hardware problem.

> 
> (5)	I returned home (200 mile round trip), removed my
> 	SCSI disks from my home machine, and then returned
> 	and installed them in my friend's machine. The
> 	machine worked perfectly with Linux version 2.2.17,
> 	and gcc-2.7.2.3, Binutils-2.8.1.0, etc., the standard
> 	stuff.
> 
> 	This shows that the problems are not because of a
> 	defective machine.
Wrong.
One cannot do statistics on one case. But you can on 10000+ of other
cases where the above just works (actually, even one case where it works
proves enough). You should give the mainboard a good massage to make it
behave more deterministically.

dust, dirt, aging, bad connectors, broken lines on the mainboard
incidentally making contact due to mechanical forces, thermal effects,
who knows what it is. It could be anything. It really is faulty hardware.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
