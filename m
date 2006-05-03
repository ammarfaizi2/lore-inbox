Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWECPbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWECPbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbWECPbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:31:12 -0400
Received: from azov.donpac.ru ([80.254.111.34]:61350 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S965118AbWECPbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:31:10 -0400
Date: Wed, 3 May 2006 19:31:28 +0400
To: David Hollis <dhollis@davehollis.com>
Cc: Michael Helmling <supermihi@web.de>, David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Message-ID: <20060503153128.GA31133@pazke.donpac.ru>
Mail-Followup-To: David Hollis <dhollis@davehollis.com>,
	Michael Helmling <supermihi@web.de>,
	David Brownell <david-b@pacbell.net>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200605022002.15845.supermihi@web.de> <200605030706.56908.supermihi@web.de> <200605022229.47937.david-b@pacbell.net> <200605031528.18809.supermihi@web.de> <1146667488.2348.28.camel@dhollis-lnx.sunera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <1146667488.2348.28.camel@dhollis-lnx.sunera.com>
X-Uname: Linux 2.6.8-12-amd64-k8 x86_64
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 123, 05 03, 2006 at 10:44:48AM -0400, David Hollis wrote:
> On Wed, 2006-05-03 at 15:28 +0200, Michael Helmling wrote:
>=20
> > So, what this Mr. Srihdar di wrong is to set his own name in the "copyr=
ight"=20
> > field instead of using yours. The process of modifying a GPLed module i=
tself=20
> > is ok, am I right with this?
> > So it should be possible to convince him of this nuisance, and then use=
 the=20
> > changes he made to make moschips device working.=20
>=20
> Correct.  He is violating the license in a number of ways, though it
> probably isn't totally intentional.  The development on that driver
> probably began before usbnet was modularized to allow for the
> componentizing of driver specific code outside of usbnet. =20

After looking at mcs7830.c source this seems highly unlikely.

> What he
> should do would be to create a moschip.c that uses usbnet as a support
> module - just like asix.c does.  In this file, he can have his sole
> Copyright attribution and not have to worry about following
> changes/updates to usbnet.  Of course, if he communicated his
> development efforts with the community, he would have received all of
> this information long ago and we'd likely help shake out bugs in the
> code to make it a more robust driver.

IMHO we should do it now. If there is no volunteers, I can try to do it,
but it will be my first USB driver, so don't expect results soon.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEWMzQPjHNUy6paxMRAuRAAKDMB+NQcZQZgvc0pB/JMkL42nanPgCeLGRf
V8XGwKmSL6nOIxuMm0fy7QQ=
=azIr
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
