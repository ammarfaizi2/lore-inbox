Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129394AbRB1XVF>; Wed, 28 Feb 2001 18:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129397AbRB1XU5>; Wed, 28 Feb 2001 18:20:57 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:49174 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S129394AbRB1XUl>; Wed, 28 Feb 2001 18:20:41 -0500
Date: Wed, 28 Feb 2001 17:20:35 -0600
From: Matthew Fredrickson <lists@frednet.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Errors compiling 2.4.2
Message-ID: <20010228172035.A23602@frednet.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I do a make bzImage I get this problem:

nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[1]: Entering directory `/usr/src/linux-2.4.2/arch/i386/boot'
ld -m elf_i386 -Ttext 0x0 -s -oformat binary bbootsect.o -o bbootsect
ld: cannot open binary: No such file or directory
make[1]: *** [bbootsect] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.2/arch/i386/boot'
make: *** [bzImage] Error 2

I don't exactly understand what's the problem but it's located at the ld
line, and I can't seem to identify what binary it can't seem to find.

I'm running debian (unstable) system, 2.4.1, Athlon-1Ghz, Asus A7Pro
board, ld version : GNU ld version 2.10.91 (with BFD 2.10.91.0.2)

Any help would be appreciated.  btw, if I just do a regular make, it works
out fine, just that one line seems to be problematic.

Matthew Fredrickson
