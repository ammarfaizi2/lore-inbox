Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272836AbRILOEP>; Wed, 12 Sep 2001 10:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272829AbRILOEF>; Wed, 12 Sep 2001 10:04:05 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:43716 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S272836AbRILODq>;
	Wed, 12 Sep 2001 10:03:46 -0400
Date: Wed, 12 Sep 2001 16:04:05 +0200
From: David Weinehall <tao@acc.umu.se>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] kernel v2.0.40-pre1
Message-ID: <20010912160405.J26627@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first pre-patch of 2.0.40. It mainly cleans up some stuff
and adds a few useful scripts. I've also added an extra-version entry
to the KERNELRELEASE. If this causes any trouble, please let me know.

I intend to do quite some cleanup of the kernel-source; my goal is to
make it compile with gcc-3.x. This does _NOT_ mean that gcc-3.x will
produce a working kernel, at least not on x86, but the code needs
some fixups none-the-less; the #endif-fixes are the first changes in
this direction. Enjoy (?)

Later v2.0.40-prepatches will also see whitespace-fixes and fixes of
at least the most horrid uses of code-formatting. My reasoning here
is consistency and making it easier to use the v2.0-kernel for
educational purposes, and to simplify my own maintainance work. Feel
free to complain. I _might_ care, but I most probably won't :^)

This release is dedicated to all the victims of the terror-attacks
vs the United States on the 11th of September 2001.


2.0.40pre1

o	Fixed the ordering of			(Philipp Rumpf)
	watchdog initialising, to make sure
	hardware watchdogs takes precedence
	over the softdog driver
o	Fix the CREDITS-entry for		(Kai Petzke)
	Kai Petzke
o	Updated the MAINTAINERS-file a little	(me)
o	Fix "dumpable"-race			(Solar Designer)
o	Fix theoretical exploit in printk	(Solar Designer)
o	Backported checkconfig.pl,		(me)
	checkhelp.pl and checkincludes.pl
	from v2.4
o	Backported support for tags and		(me)
	TAGS
o	Added an extra-version entry to		(me)
	the version#, to keep track of
	the prepatches etc.
o	Fix all occurences of			(me)
	#endif BLABLA type; don't forget
	that it should be /* BLABLA */ !!!


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
