Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbUKDUL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbUKDUL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUKDULX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:11:23 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:20159 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262397AbUKDUIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:08:51 -0500
Message-Id: <200411042008.iA4K8Sie017409@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Ian Hastie <ianh@iahastie.clara.net>
Cc: Adam Heath <doogie@debian.org>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers 
In-Reply-To: Your message of "Thu, 04 Nov 2004 19:36:26 GMT."
             <200411041936.27100.ianh@iahastie.local.net> 
From: Valdis.Kletnieks@vt.edu
References: <41894779.10706@techsource.com> <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <200411041704.iA4H4sdZ014948@turing-police.cc.vt.edu>
            <200411041936.27100.ianh@iahastie.local.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2001691947P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 04 Nov 2004 15:08:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2001691947P
Content-Type: text/plain; charset=us-ascii

On Thu, 04 Nov 2004 19:36:26 GMT, Ian Hastie said:

> How often is it necessary to do a full rebuild of the kernel?  If the 
> dependencies in the make system work properly then only the amended parts 
> should be recompiled.  That'd be a much bigger time saving than just using an 
> older compiler.

Touch the wrong .h file, and 95% of the world still gets rebuilt. Similarly,
change the wrong CONFIG_ variable and thus the size/layout of a critical
structure, and watch 95% of the world still get rebuilt.


--==_Exmh_-2001691947P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBiow7cC3lWbTT17ARAiNVAKCHd5a6vJzNCfQxT9/UXuhj2YBqBwCcDoPW
5j3ebktbNAYA1iFerfEZ/sM=
=KZkX
-----END PGP SIGNATURE-----

--==_Exmh_-2001691947P--
