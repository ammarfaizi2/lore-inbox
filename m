Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268052AbUIPNPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268052AbUIPNPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 09:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268045AbUIPNPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 09:15:41 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:20429 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268053AbUIPNPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 09:15:25 -0400
Message-Id: <200409160633.i8G6XClT019796@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: David Stevens <dlstevens@us.ibm.com>
Cc: Netdev <netdev@oss.sgi.com>, leonid.grossman@s2io.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design 
In-Reply-To: Your message of "Wed, 15 Sep 2004 14:11:04 MDT."
             <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com> 
From: Valdis.Kletnieks@vt.edu
References: <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1833311858P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Sep 2004 02:33:10 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1833311858P
Content-Type: text/plain; charset=us-ascii

On Wed, 15 Sep 2004 14:11:04 MDT, David Stevens said:

> Why don't we off-load filesystems to disks instead?  Or a graphics
> card that implements X ? :-) I'd rather have shared system resources--
> more flexible. :-)

All depends where in the "cycle of reincarnation" we are at the moment.  Way
back in 1964, IBM released this monster called System/360 - and one of the
things it did was push a *lot* of the disk processing off on the channel and
disk controller using a count-key-data format rather than the fixed-block that
Linux uses. So out on the platters, the disk format would say things like "This
is a 400 byte record, the first 56 of which is a search key". A lot of stuff,
both userspace and OS, used things like 'Search Key Equal' and letting the disk
do all the searching.

There was also this terminal beast called the 3270, which had a local
controller for the terminals, and only interrupted the CPU on 'page send' type
events.

Back then, the ideas made sense - it wasn't at all unreasonable for a single
S/360-65 to drive 3,000+ concurrent terminals in an airline reservation system or
similar (and we're talking about a box that had literally only half the
hamsters of a VAX780).

But today, the 3270 isn't seen much anymore, and currently IBM emulates the CKD
format on fixed-block systems for their z/Series boxes running z/OS or whatever MVS is
called now....


--==_Exmh_1833311858P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBSTOmcC3lWbTT17ARAmroAJ4t/GYMC09woAJLa4BvbV4TgxoNWwCgg0cW
y50v9EReZojc6s9/HwxVc58=
=yw9V
-----END PGP SIGNATURE-----

--==_Exmh_1833311858P--
