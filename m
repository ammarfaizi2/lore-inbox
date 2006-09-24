Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWIXRqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWIXRqz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 13:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWIXRqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 13:46:54 -0400
Received: from cweiske.de ([80.237.146.62]:49582 "EHLO mail.cweiske.de")
	by vger.kernel.org with ESMTP id S1751315AbWIXRqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 13:46:54 -0400
Message-ID: <4516C4B9.5010509@cweiske.de>
Date: Sun, 24 Sep 2006 19:47:37 +0200
From: Christian Weiske <cweiske@cweiske.de>
User-Agent: My own hands[TM] Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference
 at virtual address 000,0000a
References: <45155915.7080107@cweiske.de>	<20060923134244.e7b73826.akpm@osdl.org>	<451677FE.2070409@cweiske.de> <20060924095029.0262a2c8.akpm@osdl.org>
In-Reply-To: <20060924095029.0262a2c8.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig65069F579F1F56CE47AFA95F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig65069F579F1F56CE47AFA95F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andrew,


> I assume that you have confirmed that the machine doesn't have hardware=

> problems?  Does it run some earlier kernel OK? =20
The disks are both fine, they worked in other pcs without problems. The
ide controller card also worked fine, and the motherboard is new -
whatever you can expect with that. Maybe the combination is the problem.

I had some problems after running the machine for some days but I
thought that wasn't a hardware but more a kernel timing problem:
http://bugzilla.kernel.org/show_bug.cgi?id=3D6969


> And how long does it take to crash?
After starting the yacy daemon, it's about half a minute until the
"possible recursive locking detected" appears, and after one or two
minutes the whole thing crashes.


--=20
Regards/MfG,
Christian Weiske


--------------enig65069F579F1F56CE47AFA95F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFFFsS9FMhaCCTq+CMRAuYYAKDnyRzWp28z5XsrrBSwFRaiVBGvCgCdEj+2
Y4rvq+AQfN6pamFz/Sj029Q=
=x7lH
-----END PGP SIGNATURE-----

--------------enig65069F579F1F56CE47AFA95F--
