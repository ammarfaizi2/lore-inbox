Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWBGNzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWBGNzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWBGNzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:55:41 -0500
Received: from sipsolutions.net ([66.160.135.76]:13832 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S965087AbWBGNz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:55:26 -0500
Subject: Re: [RFC 3/4] firewire: unconditionally
	export	hpsb_send_packet_and_wait
From: Johannes Berg <johannes@sipsolutions.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <43E600BC.10408@s5r6.in-berlin.de>
References: <1138919238.3621.12.camel@localhost>
	 <1138920077.3621.22.camel@localhost>  <43E600BC.10408@s5r6.in-berlin.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-w+/0C2Qzu6KdRkG2mT8X"
Date: Tue, 07 Feb 2006 11:45:02 +0100
Message-Id: <1139309102.25972.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w+/0C2Qzu6KdRkG2mT8X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-05 at 14:42 +0100, Stefan Richter wrote:

> Leave the export down at the end of ieee1394_core.c among all other=20
> exports of ieee1394. Just move the export above the #ifdef.
>=20
> Same for the two new exports by "[RFC 2/4] firewire: dynamic cdev=20
> allocation below firewire major": Place them at the end of ieee1394_core.=
c.

Somehow I thought we were supposed to now put the EXPORT_SYMBOL{,_GPL}
right after the declaration. I can post a patch to move all of them
instead just the few if desired, or change this patch.

johannes

--=-w+/0C2Qzu6KdRkG2mT8X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ+h6LaVg1VMiehFYAQJZfxAApNvMkVNA/cvzpGD7BUaIu9ZpR5uam/1z
GicUNO0B9mmUkDx9W+iNS1rAH0TKdVV4Nb7wdFmdnXgsjiLw03qK7z00VcATVkif
I38Xfss9+9BY4Velk3aQ9P1NPwKZ9ll2W9E29a9cVw0nAUWj/8nba4ML4GeXhR9T
oy5/HlKjE6UxWqU9UDeYn63DVnUG9DTpvjI+0Q4PlGc88hQEZJv0M/27DDm2gihE
JF/qGJIt4QLp+k+MQYtdfw6HTElMZ7U4UOudxZOc8fUAGRnxrPfiBsnylmAo9m7F
alRBFrQ21vprKno80UNSPH/nuje+3MbiHkakmFyN2BzvSt6sl0i0/XvnKFCa6yC4
3A1ZcDf7cCw4G+c7E3r3ov75zmtQ7pUV5Cy4KwrA/5eRB2+wmL+6YgB5rD8GlNd7
PmphnI3mEhMcRh/XhYf7kxcAEEJBMYlr9BRTiqO47bpC7aGIcQMwGdjTsZ+QUOXf
1ATzespx3dPwTEA8z+PQWqOGvsYlBMi7JNjuLnG13RWnaj6iDktspncL0bdJkgK6
rM+IY9pOyChWq6EViMDmHLcgmQeiso6fmDPXsPz327WLd5n/7EpeenL5tbDDjKxK
lgIpFqfHCJpdoNbXV49L4msTxJ7ZU5dpYrT7kOYemE9p/iOhAT25BXjoj362POLH
crSKhkAPyVE=
=OKMK
-----END PGP SIGNATURE-----

--=-w+/0C2Qzu6KdRkG2mT8X--

