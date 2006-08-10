Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030535AbWHJDdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbWHJDdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 23:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWHJDdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 23:33:11 -0400
Received: from pool-72-66-192-75.ronkva.east.verizon.net ([72.66.192.75]:25284
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932287AbWHJDdK (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 23:33:10 -0400
Message-Id: <200608100332.k7A3Wvck009169@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 - ext3 locking issue?
In-Reply-To: Your message of "Wed, 09 Aug 2006 16:43:20 EDT."
             <200608092043.k79KhKdt012789@turing-police.cc.vt.edu>
From: Valdis.Kletnieks@vt.edu
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <200608091906.k79J6Zrc009211@turing-police.cc.vt.edu> <20060809130151.f1ff09eb.akpm@osdl.org>
            <200608092043.k79KhKdt012789@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1155180776_5372P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 23:32:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1155180776_5372P
Content-Type: text/plain; charset=us-ascii

On Wed, 09 Aug 2006 16:43:20 EDT, Valdis.Kletnieks@vt.edu said:

> > Usually this means that there's an IO request in flight and it got lost
> > somewhere.  Device driver bug, IO scheduler bug, etc.  Conceivably a
> > lost interrupt (hardware bug, PCI setup bug, etc).

> Aug  9 14:30:24 turing-police kernel: [ 3535.720000] end_request: I/O error, dev fd0, sector 0

Red herring.  yum just wedged again, this time with no reference to floppy drive.
Same traceback.  Anybody have anything to suggest before I start playing
hunt-the-wumpus with a -mm bisection?



--==_Exmh_1155180776_5372P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE2qjocC3lWbTT17ARAi+jAKCCzGCLX2e927M6S7n+tyVFcG6v5gCfbbQv
Xx7ebBDlumvoO61axDZGuIE=
=nczm
-----END PGP SIGNATURE-----

--==_Exmh_1155180776_5372P--
