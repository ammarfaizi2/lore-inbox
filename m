Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbSIXQQe>; Tue, 24 Sep 2002 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261697AbSIXQQe>; Tue, 24 Sep 2002 12:16:34 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22923 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S261696AbSIXQQd>; Tue, 24 Sep 2002 12:16:33 -0400
Date: Tue, 24 Sep 2002 17:21:31 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Steve Underwood <steveu@coppice.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB IEEE1284 gadgets and ppdev
Message-ID: <20020924162130.GE9457@redhat.com>
References: <3D90831A.7060709@coppice.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kqduPgYJODgMZyWh"
Content-Disposition: inline
In-Reply-To: <3D90831A.7060709@coppice.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kqduPgYJODgMZyWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2002 at 11:22:02PM +0800, Steve Underwood wrote:

> Can the USB driver for USB to IEEE1284 gadgets be used with the ppdev=20
> interface? I looked through the documentation and couldn't find a=20
> mention of this one way or the other. The structures used by parport and=
=20
> the USB stuff look similar, but I couldn't see how to get ppdev to play=
=20
> with the USB driver.

Which driver are you using?  It ought to be hooked into the parport
stuff (parport_register_driver etc) like USS720, and then it'll work.

Tim.
*/

--kqduPgYJODgMZyWh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9kJEKtO8Ac4jnUq4RAlvqAJoDm/p0gfZJSIPb4FoVkB7iyXYHjgCeL4Qj
8aIk9SIxvUHrCabBb+C3A3Y=
=vo0/
-----END PGP SIGNATURE-----

--kqduPgYJODgMZyWh--
