Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267064AbUBMPil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267059AbUBMPik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:38:40 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:24239 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267061AbUBMPhe (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:37:34 -0500
Message-Id: <200402131537.i1DFbMYZ025413@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, tytso@thunk.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Updated dynamic pty patch available 
In-Reply-To: Your message of "Wed, 11 Feb 2004 22:00:46 PST."
             <402B168E.4020000@zytor.com> 
From: Valdis.Kletnieks@vt.edu
References: <402B168E.4020000@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-977561752P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Feb 2004 10:37:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-977561752P
Content-Type: text/plain; charset=us-ascii

On Wed, 11 Feb 2004 22:00:46 PST, "H. Peter Anvin" said:
> ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/dynpty-test-2.patch
> 
> ... against the current top-of-bkcvs 2.6 kernel.
> 
> This version of the patch makes *both* legacy and Unix98 ptys configure 
> options (Unix98 only if EMBEDDED), and the number of legacy ptys is a 
> configuration option -- useful if you want to reduce the memory 
> footprint, or if you really wants lots of these guys (256 is no longer a 
> hard limit.)

Patches, compiles, boots, and runs against 2.6.3-rc2-mm1, both with
and without legacy ptys.  Haven't gotten brave enough to try without
Unix98 ptys, as I need those :)


--==_Exmh_-977561752P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFALO8ycC3lWbTT17ARAnKLAKDF0fA26T224qKxfCy7fSoYrWCWcwCdHeby
BP9tiLWmb3EPQzXt/IKWo1c=
=2BWB
-----END PGP SIGNATURE-----

--==_Exmh_-977561752P--
