Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTEIHbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbTEIHbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:31:00 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:24252 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262340AbTEIHa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:30:58 -0400
Date: Fri, 9 May 2003 10:43:32 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030509074332.GB14991@actcom.co.il>
References: <200305071507_MC3-1-37CF-FE32@compuserve.com> <1052387912.4849.43.camel@pc-16.office.scali.no> <20030508095943.B22255@devserv.devel.redhat.com> <1052398474.4849.57.camel@pc-16.office.scali.no> <20030508135839.A6698@infradead.org> <3EBAAB9D.5000508@shemesh.biz> <20030508201509.A19496@infradead.org> <20030508214811.GC3458@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20030508214811.GC3458@werewolf.able.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2003 at 11:48:11PM +0200, J.A. Magallon wrote:

> Don't have followed the whole thread, so I don't know if somebody has alr=
eady
> said this, but all this thing about hooks looks perfect for projects like
> bproc or mosix, have you talked to them ?
> (perhaps Erik Hendriks <erik@hendriks.cx> -bproc- is following the
thread...;) )

I don't know about bproc, but at least MOSIX is, as it currently
stands, a kernel patch. Therefore, they can (and do) hijack the
syscall table safely. If I remember the code correctly, they do it in
entry.S, not in the sys_call_table itself.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+u1wkKRs727/VN8sRAmOJAJ0a/fIIqPC3u3P2nHfXbcrtN+L9gQCeIZIG
jANKYgszsIi85aph22bTQY8=
=LSJT
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
