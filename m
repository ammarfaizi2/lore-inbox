Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264252AbRFYWMj>; Mon, 25 Jun 2001 18:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264340AbRFYWM3>; Mon, 25 Jun 2001 18:12:29 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:1798 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264252AbRFYWMV>; Mon, 25 Jun 2001 18:12:21 -0400
Date: Mon, 25 Jun 2001 17:12:01 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: rio500-devel <rio500-devel@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] rio500 devfs support
Message-ID: <20010625171201.A13305@glitch.snoozer.net>
Mail-Followup-To: rio500-devel <rio500-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.redhat.com>
In-Reply-To: <20010619175224.A1137@glitch.snoozer.net> <20010625103521.A17036@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20010625103521.A17036@kroah.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Sun Jun 24 16:53:30 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was thinking of doing some similar updates this evening after work.=20
Darn it... now I have to find something else to do!  :-)

Going by this morning's comments from Richard Gooch, it sounds like the

	if (rio->devfs =3D=3D NULL)
		dbg("probe_rio: device node registration failed");

part should probably be removed... it looks good to me otherwise, tho.=20
I'll try it out tonight and post the results.

Cheers!

On Mon, Jun 25, 2001 at 10:35:21AM -0700, Greg KH wrote:
> Here's a small change that makes the node a child of the usb devfs
> entry.  It also enables the node to only be present when the device is
> actually present.  The patch is against 2.4.6-pre5.
>=20
> thanks,
>=20
> greg k-h

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7N7cxgrEMyr8Cx2YRAihIAJ0TrL5c9gYAT71KNuegwaexR3lhagCgyaB7
fBuPH9ojcoO42S5aOCQqg0g=
=/5Eq
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
