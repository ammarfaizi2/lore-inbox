Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTLYTj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 14:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTLYTj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 14:39:59 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:37592 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S262446AbTLYTj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 14:39:57 -0500
Date: Thu, 25 Dec 2003 21:39:49 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrea Barisani <lcars@infis.univ.trieste.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0, wrong Kconfig directives
Message-ID: <20031225193948.GP31789@actcom.co.il>
References: <20031222235622.GA17030@sole.infis.univ.trieste.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7PAM/4G1BR2SfWzg"
Content-Disposition: inline
In-Reply-To: <20031222235622.GA17030@sole.infis.univ.trieste.it>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7PAM/4G1BR2SfWzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2003 at 12:56:23AM +0100, Andrea Barisani wrote:

> - SOUND_GAMEPORT option is always turned on
>=20
> ./drivers/input/gameport/Kconfig
>=20
> 22: config SOUND_GAMEPORT
> 23:         tristate
> 24:         default y if GAMEPORT!=3Dm
> 25:         default m if GAMEPORT=3Dm

> line 24 is definetly wrong, option is enabled if GAMEPORT=3Dn.

line 24 is correct. CONFIG_SOUND_GAMEPORT is an odd beast, see
e.g.
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D106479206731633&w=3D2 for
details. Please leave poor CONFIG_GAMEPORT alone.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--7PAM/4G1BR2SfWzg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6z0EKRs727/VN8sRAu28AJ9uxfWOSuMPsFEqIhIWRn0neOiqDwCfSmh2
/nu3ws1qxnSYpaYkdbF13yQ=
=eNrh
-----END PGP SIGNATURE-----

--7PAM/4G1BR2SfWzg--
