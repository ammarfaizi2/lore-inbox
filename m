Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTKNUm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTKNUm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:42:27 -0500
Received: from coruscant.franken.de ([193.174.159.226]:58042 "EHLO
	dagobah.gnumonks.org") by vger.kernel.org with ESMTP
	id S261947AbTKNUm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:42:26 -0500
Date: Fri, 14 Nov 2003 21:37:37 +0100
From: Harald Welte <laforge@netfilter.org>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [2.6] Nonsense-messages from iptables + co.
Message-ID: <20031114203737.GI6937@obroa-skai.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
References: <20031114132054.GA646@merlin.emma.line.org> <20031114151004.GE2395@obroa-skai.de.gnumonks.org> <20031114200119.GA27789@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline
In-Reply-To: <20031114200119.GA27789@merlin.emma.line.org>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre7-ben0
X-Date: Today is Pungenday, the 26th day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2003 at 09:01:19PM +0100, Matthias Andree wrote:

> > I guess it was Rusty.  The idea message is a funny way of telling you
> > that you are sending incomplete ip headers.
>=20
> Am I? what's with the *_limit() function called before the printk?

it's a generic network rate limiting function.  It prevents the same
message from being logged and logged again (and thus flooding your
syslog).

> > Something that is not likely to occur unless you are trying to send
> > corrupt packets via raw ip sockets...
>=20
> Not at the times when these occurred.

there seemed to be a bug that I was unaware of, and according to other
mails in this thread it has been fixed.
=20
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tT0RXaXGVTD0i/8RApkEAJsEg3wPDHHXLEuImo0KOu664P3J+QCfaCC9
iD83iiPSOXKldXorCBNRb9U=
=17iT
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
