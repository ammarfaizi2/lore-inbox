Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271967AbRIDN2B>; Tue, 4 Sep 2001 09:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271970AbRIDN1v>; Tue, 4 Sep 2001 09:27:51 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:5460 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S271967AbRIDN1n>; Tue, 4 Sep 2001 09:27:43 -0400
Date: Tue, 4 Sep 2001 14:27:55 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Michael Ben-Gershon <mybg@netvision.net.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lpr to HP laserjet stalls
Message-ID: <20010904142755.V20060@redhat.com>
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com> <3B94B4E7.701C76FA@netvision.net.il> <20010904121523.Q20060@redhat.com> <3B94B93B.2B907DCF@netvision.net.il> <20010904122751.S20060@redhat.com> <3B94D58B.180860A2@netvision.net.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="z2hf4YSN3H4nBSDp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B94D58B.180860A2@netvision.net.il>; from mybg@netvision.net.il on Tue, Sep 04, 2001 at 04:22:19PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z2hf4YSN3H4nBSDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2001 at 04:22:19PM +0300, Michael Ben-Gershon wrote:

> I don't know what they mean (the printing itself was not affected) but
> I guess it would be better to avoid modes which give such messages.

They are normal, really, and are there to help debugging.

> At the moment I am loading the module with:
>=20
> 	insmod parport
> 	insmod parport_pc io=3D0x378,0xa800 irq=3Dauto,auto dma=3Dnofifo,nofifo

So this is interrupt-driven printing but without using the ECP
hardware.  I wonder why CONFIG_PARPORT_PC_FIFO makes a difference.  It
shouldn't, really, and neither should building it as a module.

Strange.

Tim.
*/

--z2hf4YSN3H4nBSDp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE7lNbayaXy9qA00+cRAvS2AJiOOThJGJmqEuIAhMy2C1y3jWrJAJ0YS0bK
wqMX91ZUa1hxpCacCWZ49Q==
=g6WU
-----END PGP SIGNATURE-----

--z2hf4YSN3H4nBSDp--
