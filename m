Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLQIi5>; Sun, 17 Dec 2000 03:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQLQIir>; Sun, 17 Dec 2000 03:38:47 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:6667 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129348AbQLQIim>; Sun, 17 Dec 2000 03:38:42 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14908.29798.413845.663365@wire.cadcamlab.org>
Date: Sun, 17 Dec 2000 02:08:06 -0600 (CST)
To: ferret@phonewave.net
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
In-Reply-To: <20001216174351.N3199@cadcamlab.org>
	<Pine.LNX.3.96.1001216190142.25257A-100000@tarot.mentasm.org>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ferret@phonewave.net <ferret@phonewave.net>]
> I have not moved or deleted a tree. I do not HAVE a kernel tree in
> the first place. Therefore, nothing for the symlink to point to when
> I install the kernel.

If this is not the machine you compile your kernels on, why are you
compiling your external modules on it?

In any case, at the very least you need a copy of the appropriate
kernel headers.  Some distributions have packages for these to match
their kernel image packages.  If that's where you got yours, the
packaging should have included the build/ symlink.  If it doesn't, file
a bug.  And incidentally, also file one if the "kernel headers" package
doesn't come with Makefile, Rules.make, arch/$ARCH/Makefile and
.config .  (Those four are very useful for getting your settings right
when compiling external modules.)

If you installed the headers *without* any infrastructure support from
a distribution, then once again I don't think you need "External Module
Compiling for Dummies", and all of the above is *your* job.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
