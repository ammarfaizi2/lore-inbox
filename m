Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265779AbUAFEfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbUAFEfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:35:47 -0500
Received: from h80ad2537.async.vt.edu ([128.173.37.55]:19073 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265779AbUAFEfk (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:35:40 -0500
Message-Id: <200401060435.i064ZJW9004901@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?) 
In-Reply-To: Your message of "Tue, 06 Jan 2004 05:24:17 +0100."
             <3FFA3871.5060208@conet.cz> 
From: Valdis.Kletnieks@vt.edu
References: <3FFA30FA.1040602@conet.cz> <200401060412.i064CJtK004302@turing-police.cc.vt.edu>
            <3FFA3871.5060208@conet.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_333215303P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jan 2004 23:35:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_333215303P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Jan 2004 05:24:17 +0100, Libor Vanek said:

> Why does anybody try to do this? Is there any reason for it? 

You never seen a program do something like:

	if (!strcmp(argv[i],"-f") {
		infile = open(argv[i+1],...);

without a check that argv[i+i] actually points anyplace reasonable? ;)

--==_Exmh_333215303P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/+jsHcC3lWbTT17ARAlldAJ9iKPqjrUPI12dBnFSVtuQpMF8neQCg1w7D
F+4TqpWwMqQxhEG7RUYMrT8=
=jcIi
-----END PGP SIGNATURE-----

--==_Exmh_333215303P--
