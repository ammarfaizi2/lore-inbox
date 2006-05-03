Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWECOrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWECOrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWECOrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:47:05 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:51369 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S965109AbWECOrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:47:02 -0400
Date: Wed, 03 May 2006 10:44:48 -0400
From: David Hollis <dhollis@davehollis.com>
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
In-reply-to: <200605031528.18809.supermihi@web.de>
To: Michael Helmling <supermihi@web.de>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <1146667488.2348.28.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-6Ygq4p6T0mKuHN5r2Lo0"
References: <200605022002.15845.supermihi@web.de>
	<200605030706.56908.supermihi@web.de>	<200605022229.47937.david-b@pacbell.net>
	<200605031528.18809.supermihi@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6Ygq4p6T0mKuHN5r2Lo0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-03 at 15:28 +0200, Michael Helmling wrote:

> So, what this Mr. Srihdar di wrong is to set his own name in the "copyrig=
ht"=20
> field instead of using yours. The process of modifying a GPLed module its=
elf=20
> is ok, am I right with this?
> So it should be possible to convince him of this nuisance, and then use t=
he=20
> changes he made to make moschips device working.=20

Correct.  He is violating the license in a number of ways, though it
probably isn't totally intentional.  The development on that driver
probably began before usbnet was modularized to allow for the
componentizing of driver specific code outside of usbnet.  What he
should do would be to create a moschip.c that uses usbnet as a support
module - just like asix.c does.  In this file, he can have his sole
Copyright attribution and not have to worry about following
changes/updates to usbnet.  Of course, if he communicated his
development efforts with the community, he would have received all of
this information long ago and we'd likely help shake out bugs in the
code to make it a more robust driver.

--=20
David Hollis <dhollis@davehollis.com>

--=-6Ygq4p6T0mKuHN5r2Lo0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEWMHgxasLqOyGHncRAkoZAKClpdo7Ev0eOoCimJWmJFpyhW1zQQCfdL32
i/zDVnWvM7r5sy87PrEdrg4=
=z840
-----END PGP SIGNATURE-----

--=-6Ygq4p6T0mKuHN5r2Lo0--

