Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbTIIODe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTIIODe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:03:34 -0400
Received: from mail-09.iinet.net.au ([203.59.3.41]:23946 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263890AbTIIODb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:03:31 -0400
Subject: Re: USB - UHCI not SMP capable? linux-2.6-test4
From: Sven Dowideit <svenud@ozemail.com.au>
Reply-To: svenud@ozemail.com.au
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-acpi <linux-acpi@intel.com>
In-Reply-To: <20030908084234.B13225@beaverton.ibm.com>
References: <7F740D512C7C1046AB53446D3720017304AF12@scsmsx402.sc.intel.com>
	 <1063050150.2977.17.camel@sven>  <20030908084234.B13225@beaverton.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WuyoucTtW/ZWMhRGA9Gh"
Message-Id: <1063151741.975.15.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 10 Sep 2003 09:55:41 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WuyoucTtW/ZWMhRGA9Gh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

mmm, i think i get a partial success, but the mouse is still not
functioning=20

lsusb is still not listing any devices, is there anything else i can
look at? (i still have not built test5 - thats tomorrow)

from test4 and Duncan's patch

drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus
number 1
hub 1-0:0: USB hub found
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 1-0:0: new USB device on port 1, assigned address 2
lirc_usb: USB remote driver for LIRC v0.1


thanks


On Tue, 2003-09-09 at 01:42, Patrick Mansfield wrote:
> On Tue, Sep 09, 2003 at 05:42:30AM +1000, Sven Dowideit wrote:
> > ok , as I have not had any success with ACPI i have it turned off on al=
l
> > my computers. I added acpi=3Doff to my boot parameters just in case, bu=
t
> > USB is still non-functional.
> >=20
> > sorry, that wasn't it
>=20
> Did you try Duncan's patch:
> =20
> http://marc.theaimsgroup.com/?l=3Dlinux-usb-devel&m=3D106282603828913&w=
=3D2
>=20
> The patch above applies to plain test4 with some offsets.
>=20
> It fixed my problem (I havde UP, with slab debug on).
>=20
> -- Patrick Mansfield
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=-WuyoucTtW/ZWMhRGA9Gh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/Xmh9PAwzu0QrW+kRAktaAKC5+wiNLVaGUCFWcZr/jLOk/i8S3ACeI+aS
+oasS1eGUuUjJCt0bchfAjU=
=Y/8r
-----END PGP SIGNATURE-----

--=-WuyoucTtW/ZWMhRGA9Gh--

