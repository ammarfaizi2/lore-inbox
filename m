Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRBLWmS>; Mon, 12 Feb 2001 17:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRBLWmI>; Mon, 12 Feb 2001 17:42:08 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:61389 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129267AbRBLWl4>; Mon, 12 Feb 2001 17:41:56 -0500
Date: Mon, 12 Feb 2001 22:41:46 +0000
From: Tim Waugh <twaugh@redhat.com>
To: "John B. Jacobsen" <jbj_ss@mail.tele.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RedHat 7.0 4.1 / lpd warning
Message-ID: <20010212224146.G911@redhat.com>
In-Reply-To: <200102122150.f1CLoNC00878@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102122150.f1CLoNC00878@localhost.localdomain>; from jbj_ss@mail.tele.dk on Mon, Feb 12, 2001 at 10:50:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2001 at 10:50:23PM +0100, John B. Jacobsen wrote:

> Starting lpd: Warning - lp: cannot open lp device '/dev/lp0' - No such de=
vice
> Warning - dj: cannot open lp device '/dev/lp0' - No such device
>=20
> Why is that ? /dev/lp surely exists !

It's telling you that the driver is not loaded or won't load.  What
happens if you do 'modprobe parport_lowlevel'?

Tim.
*/

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6iGapONXnILZ4yVIRAr8sAKCVssxrZtMp3snadyq0bp1PrixSBgCcDhKB
GccaQE+IdRtur1CNGEsjkuo=
=e8gD
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
