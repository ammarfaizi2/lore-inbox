Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271695AbTG2Ppy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271834AbTG2Ppy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:45:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:34688 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271695AbTG2Ppx (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:45:53 -0400
Message-Id: <200307291545.h6TFjk3o005053@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Timothy Miller <miller@techsource.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O10int for interactivity 
In-Reply-To: Your message of "Tue, 29 Jul 2003 11:44:11 EDT."
             <3F26964B.3070900@techsource.com> 
From: Valdis.Kletnieks@vt.edu
References: <200307280112.16043.kernel@kolivas.org> <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu> <3F2682EF.2040702@techsource.com> <200307291528.h6TFSo3o004775@turing-police.cc.vt.edu>
            <3F26964B.3070900@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1455990548P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Jul 2003 11:45:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1455990548P
Content-Type: text/plain; charset=us-ascii

On Tue, 29 Jul 2003 11:44:11 EDT, Timothy Miller said:

> Heh... can we prioritize swapping based on interactivity information?  :)

That concept has been seen before in other operating systems, and I'm
pretty sure that although Con and Ingo are doing stellar work, they will
soon have to start feeding back I/O and paging patterns into the calculations...

In the meantime, I probably need to see what tweaking the various paging
controls does... /proc/sys/vm/swappiness looks like a good place to start. ;)

--==_Exmh_1455990548P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/JpaqcC3lWbTT17ARAu2TAJ0cRnBmlMBNMY3SAATyNgJAa6ffawCgsGPF
95CJQVxM9G1dOt6QDJwzrMA=
=xscv
-----END PGP SIGNATURE-----

--==_Exmh_1455990548P--
