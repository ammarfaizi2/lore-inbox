Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVIQP3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVIQP3f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 11:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIQP3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 11:29:35 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:51129 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751116AbVIQP3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 11:29:34 -0400
Date: Sat, 17 Sep 2005 17:29:31 +0200
From: Harald Welte <laforge@netfilter.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Netdev List <netdev@vger.kernel.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [HELP] netfilter Kconfig dependency nightmare
Message-ID: <20050917152931.GA8413@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	Linux Netdev List <netdev@vger.kernel.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20050916021451.3012196c.akpm@osdl.org> <20050916191959.GN8413@sunbeam.de.gnumonks.org> <39e6f6c705091617514457eded@mail.gmail.com> <20050917012315.GA29841@mandriva.com> <20050917080714.GV8413@sunbeam.de.gnumonks.org> <Pine.LNX.4.61.0509171306290.3743@scrub.home> <20050917112949.GZ8413@sunbeam.de.gnumonks.org> <Pine.LNX.4.61.0509171407460.3743@scrub.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kxn/JluRpPoM1h3S"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509171407460.3743@scrub.home>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kxn/JluRpPoM1h3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 17, 2005 at 02:18:28PM +0200, Roman Zippel wrote:
> Since IP_NF_CONNTRACK_NETLINK is the one creating the dependency,=20
> something like this should work:

yes, I agree.  Looking at the behaviour of "menuconfig", I think your
suggestion solves the problem.  I didn't try to compile all the
combinations, though.

I'll submit a patch via DaveM soon.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--kxn/JluRpPoM1h3S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLDZbXaXGVTD0i/8RAmpgAKCOSIau5tzkHy5MkKL9vPKiEDk/0QCgjTSo
K7vRP5yzzrkKGrXjIGBcUWs=
=rw/1
-----END PGP SIGNATURE-----

--kxn/JluRpPoM1h3S--
