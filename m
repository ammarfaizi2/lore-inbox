Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbTKITFg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbTKITFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:05:36 -0500
Received: from h80ad2653.async.vt.edu ([128.173.38.83]:41874 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262772AbTKITFS (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:05:18 -0500
Message-Id: <200311091905.hA9J5BiA004728@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about stable kernel development 
In-Reply-To: Your message of "Sun, 09 Nov 2003 19:41:02 +0100."
             <m3u15de669.fsf@defiant.pm.waw.pl> 
From: Valdis.Kletnieks@vt.edu
References: <m3u15de669.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-480839598P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Nov 2003 14:05:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-480839598P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Nov 2003 19:41:02 +0100, Krzysztof Halasa said:

> Say, we're now at 2.4.23-rc1 stage. This "rc" kernel would also be
> known as 2.4.24-pre1. The maintainer would apply "rc"-class fixes to
> both kernels, and other patches (which can't go to "rc" kernel) would
> be applied to 2.4.24-pre1 only.

Two kernels getting different patches... (consider the case of a security
patch that hits code that was already hit by a previous -preN-ony patch,
so two different diffs are needed for the two trees)

> - we would avoid a mess of having two separate trees, with different
>   fixes going in and out.

So I don't see how this follows?

--==_Exmh_-480839598P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ro/mcC3lWbTT17ARAjaKAKDQGCURD/6bg3Wk2Loh++qLdLULKgCfUYwa
evi1oKJ9vnN1qT4IuVFd4bY=
=4wli
-----END PGP SIGNATURE-----

--==_Exmh_-480839598P--
