Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbRAIWsY>; Tue, 9 Jan 2001 17:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132271AbRAIWsO>; Tue, 9 Jan 2001 17:48:14 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:26303 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S130231AbRAIWsH>; Tue, 9 Jan 2001 17:48:07 -0500
Date: Tue, 9 Jan 2001 23:48:04 +0100
From: David Weinehall <tao@acc.umu.se>
To: linux-kernel@vger.kernel.org
Subject: [Announcement] linux-kernel v2.0.39
Message-ID: <20010109234804.E18733@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone laughs, I guess. The 2.0.39final didn't became the final
release (could've told you so...) The good thing? Well, some bugs were
found and removed. But this is it. Enjoy!


Changelog for v2.0.39

o	Fix memory-leak in af_unix		(Jon Nelson,
						 Alan Cox, me)
o	Added headerfiles for devfs		(Richard Gooch)
	to simplify backports of
	drivers
o	Fix a bug involving syncronous		(Jari Ruusu)
	writes and -ENOSPC that could
	cause file-corruption
o	Added new versions of PCI-2000		(Mark Ebersole)
o	Added new versions of PCI-2220i		(Mark Ebersole)
o	Fixed a few typos in PCI-2000,		(me)
	PCI-2220i, PSI-240i and related
	files
o	Removed unused variable in xd.c		(me)
o	Renamed the initfunctions in		(me)
	pi2.c and pt.c, as their names
	clashed with paride-names
	(obviously, noone uses paride
	 together with hamradio)
o	Changed most references to		(me)
	vger.rutgers.edu to
	vger.kernel.org
o	Fix the few vger.rutgers.edu		(Daniel Roesen)
	references that I missed
o	Fix a bug in af_unix that wrote to	(Michael Deutschmann)
	a socket after freeing it
	(aka the Win9x-related oops)
o	Fixed typo in Documentation		(Martin Douda)
o	IDE-patches				(Andre Hedrick)
o	Fixes for the IDE-patches		(Andries Brouwier,
o	Move memory-offset for dynamic		(Michael Deutschsmann)
	executables
o	Fixes to the Cyclades-driver		(Ivan Passos)
o	Fix for a bug in ext2			(Stephen C. Tweedie)
o	Added marketing-names for 3Com		(Yann Dirson, me)
	NICs in drivers/net/Config.in
o	Fix for a buf in smbfs			(Rick Bressier)
o	Large-disk fixes			(Andries Brouwer)
o	Wavelan-driver cleanup & bugfixes	(Jean Tourrilhes)
o	Security-fixes				(Solar Designer)
o	Quota-fixes				(Jan Kara)
o	Fixed GPF using IPsec Masquerade	(Rudolf Lippan)
o	Fixed Config.in bugs in			(Marc Martinez)
	drivers/net and drivers/isdn
o	Added IPX-routing of NetBIOS packages	(Jan Rafaj)
o	Fix for a bug in paride			(Wolfram Gloger)
o	Fix an erroneous printk in ip_fw.c	(Todd Sabin)
o	Fix for IP multicast on WAN-adapters	(Matthew Grant)
o	Big updates to MAINTAINERS		(me)
o	Big updates to CREDITS			(me, others)
o	Various updates in Documentation/*	(me)
o	Styled up all Configuration-files	(me)
	in a similar manner to newer
	v2.3 kernels, and various other
	cleanups
o	Updated CodingStyle to the one used	(me)
	in recent v2.3 kernels
o	Backported nls_8859-14			(me)
o	Added support for sparse superblocks	(Theodore T'so)
o	Fix for the ping -s 65468 exploit	(Andrea Arcangeli, others)


Enjoy!

/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
