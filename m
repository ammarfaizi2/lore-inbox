Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUBHBWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUBHBWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:22:19 -0500
Received: from h80ad24ed.async.vt.edu ([128.173.36.237]:4736 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261779AbUBHBUG (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:20:06 -0500
Message-Id: <200402080115.i181Fn9q002138@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-mm1, selinux, and initrd 
In-Reply-To: Your message of "Sat, 07 Feb 2004 08:49:28 EST."
             <Xine.LNX.4.44.0402070846040.19428-100000@thoron.boston.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0402070846040.19428-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1006884204P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 07 Feb 2004 20:15:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1006884204P
Content-Type: text/plain; charset=us-ascii

On Sat, 07 Feb 2004 08:49:28 EST, James Morris said:

> Ok, looks like a problem where devfs is passing an empty string to 
> do_mount when it expects a page.
> 
> Please try the patch below against 2.6.2-mm1.

OK, thanks.. that's a "confirmed working"...

--==_Exmh_1006884204P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAJY3EcC3lWbTT17ARAkAoAKDtHtjHHNZX0d+xjUuMYBI1+DQaSgCfVOeK
CBBhbrVl7gCu7pfgAIopsXw=
=xjOu
-----END PGP SIGNATURE-----

--==_Exmh_1006884204P--
