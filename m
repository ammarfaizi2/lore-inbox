Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTJMO7W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 10:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTJMO7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 10:59:22 -0400
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:57277 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S261820AbTJMO7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 10:59:15 -0400
Subject: Re: [2.6.0-test7-bk][OOPS] Unable to handle kernel paging request
	at virtual address f9a7e857
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20031013033459.3519f83b.akpm@osdl.org>
References: <1065959373.1111.13.camel@debian>
	 <20031013033459.3519f83b.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z6QCSsZ7XFOQY1RPnuzr"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1066057147.1003.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 13 Oct 2003 16:59:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z6QCSsZ7XFOQY1RPnuzr
Content-Type: multipart/mixed; boundary="=-xfQu4kL5+44RD7apjuNY"


--=-xfQu4kL5+44RD7apjuNY
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

El lun, 13-10-2003 a las 12:34, Andrew Morton escribi=F3:

> You get the award for the weirdest bug report of the 21st century.  There
> is just no way in which kswapd can call ->readpages().
>=20
> The only thing I can think of is that an inode's superblock's ->put_inode
> pointer somehow got set to point at ext3_readpages().  Or we got a
> completely wild pointer in prune_dcache().  Some sort of memory scribble,
> anyway.
>=20
> What sort of machine is it?  Nice, new and stable or old, nasty and likel=
y
> to tromp its memory?

My machine is a k6-2 450, 256 MiB of RAM, and is stable and solid. I use
it as my desktop system, and the memory keeps coherent always, after
hours of activity. No crashes, no randomly hangs,...
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-xfQu4kL5+44RD7apjuNY
Content-Disposition: attachment; filename=dmesg.log.gz
Content-Type: application/x-gzip; name=dmesg.log.gz
Content-Transfer-Encoding: base64

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

--=-xfQu4kL5+44RD7apjuNY
Content-Disposition: attachment; filename=versions.log.gz
Content-Type: application/x-gzip; name=versions.log.gz
Content-Transfer-Encoding: base64

H4sICJarij8CA3ZlcnNpb25zLmxvZwBtUstu2zAQvOsrFuilPYgRJfjVq2wEBpw0SFL0KNDk2iZM
clU+0vjvSymJ08QlBGiXoxnOULveQSCLsNNoVADhEdD28QTkwRAdIbkUkjBwogRWnOAgnhCEAzIK
ntAHTY4VLdl+oEaCeECQyXt0Eax22maux99Je7R5L4B2sCSZhkbEzL5qD8LtMbACio126RkUbnU+
oWZTVpURQ5zBF17DDTn4ISPwBvjke36qKbSrh0eoq6oBPZlP4fr259WokbWuXYIWLlbDGlaPoBVH
vADnVZGiNqUZnfy7asbrwlLKuS7WK6aSwTJnjmUkMuEFq9iC8UnZe6wLrHeh97QPH+mcNZPy1/ru
NX8LG731wp/e5QfPy5MTVkvI1o7o4atR6tsZvPMk+/CftHywdosfLL2fO63yv3OBsu9PeMWycPFw
KIfr+Cw8YTkVL27GxAE2JBSqM+p5PYfgVNdL21EIY231M/pzhy7wZsbH2os/Viv9xnh5iz12whiS
Yxu1zYmHSsjFrJOkUMJeWOzJx2EfdB+7kAcKh0psDXY7bWImDcD9arm+X7WPZ8yJmOus41z0Qh6H
ZkQCpIPU3UEqSGErKc+0DrQLMOfNIt9QHmkN0sumBq2wy59J5ckWfwH5cu2qRwMAAA==

--=-xfQu4kL5+44RD7apjuNY--

--=-Z6QCSsZ7XFOQY1RPnuzr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/ir26RGk68b69cdURAi77AJ9EGW3u8gYhtC0Aeb6GWX5Q//kpiACfRIQj
a44olqm48nqqWwWWSU1qHZE=
=7inF
-----END PGP SIGNATURE-----

--=-Z6QCSsZ7XFOQY1RPnuzr--

