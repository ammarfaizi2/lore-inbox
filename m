Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267221AbUBNA6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUBNA6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:58:48 -0500
Received: from h80ad253b.async.vt.edu ([128.173.37.59]:34506 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267221AbUBNA6M (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:58:12 -0500
Message-Id: <200402140056.i1E0ubxI020512@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: Michael Frank <mhf@linuxmail.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle 
In-Reply-To: Your message of "Fri, 13 Feb 2004 19:38:21 EST."
             <20040214003821.GA8183@arizona.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <200402130615.10608.mhf@linuxmail.org>
            <20040214003821.GA8183@arizona.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_952211339P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Feb 2004 19:56:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_952211339P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Feb 2004 19:38:21 EST, "Kevin O'Connor" said:

> 1 - kfree already checks for null, so checking for null before calling
>     kfree is pointless.

As anybody who's chased a 'null pointer dereference' OOPS, plenty of
stuff in the kernel DOESN'T check for null.  And this is a *style*
document, not a calling conventions document (unless we're documenting
the use of kmalloc/kfree as well as layout?

If we're doing that, we may well want to expand it slightly to cover
the case of 2 kmallocs, a 'goto out1' and 'goto out2' to demonstrate
proper unwinding/freeing....

--==_Exmh_952211339P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFALXJFcC3lWbTT17ARAonPAKDrfKGz3uyEBGjsSVcOqaE7WPP24ACdEy33
SpJPYFgdnIuUh8/rd0XqNw4=
=vTNJ
-----END PGP SIGNATURE-----

--==_Exmh_952211339P--
