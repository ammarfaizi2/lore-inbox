Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTIQCkS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 22:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbTIQCkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 22:40:18 -0400
Received: from adsl-67-124-157-90.dsl.pltn13.pacbell.net ([67.124.157.90]:2784
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S262665AbTIQCkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 22:40:13 -0400
Date: Tue, 16 Sep 2003 19:40:11 -0700
To: linux-kernel@vger.kernel.org
Cc: mochel@osdl.org
Subject: Re: Swsusp weirdness with ACPI
Message-ID: <20030917024011.GA11587@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
	mochel@osdl.org
References: <20030913210722.GA264@anemic> <Pine.LNX.4.33.0309150955360.950-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309150955360.950-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2003 at 10:03:14AM -0700, Patrick Mochel wrote:
> Also, if you're willing, I would recommend trying 2.6.0-test5-mm2, which
> will allow you to try the original swsusp code (via /proc/acpi/sleep)
> independently of the more recent suspend-to-disk code (via=20
> /sys/power/state).

With 2.6.0-test5-mm2,=20

- 4/4bios don't do anything
- 3 will stop tasks... I got a "<6>Strange, ircd not stopped" once, and
  I removed my wifi card and it was good. (Yes, ircd was listening on
  it.)

  But after all of this hubbub it still won't come back to life. :(

I will try the other stuff later, I'm short of time these days.
Thanks for your help so far.

--=20
Joshua Kwan

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP2fJiaOILr94RG8mAQKGZA//Xypify70VRSgp+iCkERilDgtuHTuGjV9
2L3M479fyGmeCDIhQDT+5rBNxwtCSdlYc/JJ1NGPXclEhewZfMUb+UsWACskAeuf
Rtiqiy/UfqFcKLfm9HcNsKlWGOE9nubCPpSwRyN+fBCgGWP1C7Ey5ypezBtFquEp
vwWQZ2D6qvWLWhQflzUNjkZnXoAcczohgWib93eu5HCh3whSEsIEliUvurmZnXWN
A7jvC91r2nGrGMzmPiJr+IiB1hXlD/tuBvKfluJMBsVeUMEIO86rX5M3+Toy/HRr
LqEGN95/ue2/YDSScdtMfUwduj0P9/hvyG4IXQqV/xiirtAfNrqMCnqS6Wl7Xqo+
2QDV8tYKcd9qt3MD/miPoDskYbSCLLrVuNuo9S/N/NRP4fzz5o1ku5esaUYQLhF9
aYuHUg3cxs5Ntx6fup0yP10bCJtUIP9PPEISlYWB4rCBsajzP0gN6sBBmKPXG/U1
PlW1PN8Ov26xZWXCDbeDtb7GzqbdO3ttcFguDLyih0z1VIjavLost8+ZAAcGSDTt
dzS6J92OojbBbUci1u+c9j2qGtoYEYVUIJBZ+TAb/3igJPmWbJd8YVaVfzgohXHy
KUr7LacxEAyBNKH8wlq+g2B70McM92FWwlwFxdBDvDX1sIw0dJFYxUnBWv1vQhsY
/sV0qmM29bI=
=u7xO
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
