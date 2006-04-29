Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWD2FhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWD2FhA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 01:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWD2FhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 01:37:00 -0400
Received: from h80ad24a4.async.vt.edu ([128.173.36.164]:25486 "EHLO
	h80ad24a4.async.vt.edu") by vger.kernel.org with ESMTP
	id S1750723AbWD2Fg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 01:36:59 -0400
Message-Id: <200604290536.k3T5arZs012263@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: khaled MOHAMMED atteya <khaled.m.atteya@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I hope to be kernel developer ,in i386 arch 
In-Reply-To: Your message of "Sat, 29 Apr 2006 00:54:28 +0300."
             <7f9112a50604281454k27d60e4cm61d5bb659c3f8359@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <7f9112a50604281454k27d60e4cm61d5bb659c3f8359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146289012_2469P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 29 Apr 2006 01:36:52 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146289012_2469P
Content-Type: text/plain; charset=us-ascii

On Sat, 29 Apr 2006 00:54:28 +0300, khaled MOHAMMED atteya said:
> HELLO
> I hope to be kernel developer ,in i386 arch.

Do you plan to be actively developing code in the arch/i386 tree, or are
you just developing on systems that happen to be x86 boxes?  The difference
is crucial.

> am i needing to read all i386 and pentium manual (the three volume)?

There's large portions of the kernel ( fs/* and net/* in particular) that
are largely CPU-agnostic.  Much more important overall is understanding the
basic *concepts* of barriers (why you need them, when, and where), and trusting
the provided macros to Do The Right Thing when you use the right macro (conversely,
using the *wrong* macro is an error no matter what architecture you're on).

That, and locking.  Understanding locking is another things more important
than the actual CPU registers.

And you need to get a grip on both of those concepts before starting to deal
with architecture-dependent code (of which there's an amazingly small amount).

--==_Exmh_1146289012_2469P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEUvtzcC3lWbTT17ARAmeWAKCX9SG4eo/FU+QS+Z7G8RJYV0yN7ACg9zhk
rjQK4U2q5CznbBKYyDsaL9Y=
=69uM
-----END PGP SIGNATURE-----

--==_Exmh_1146289012_2469P--
