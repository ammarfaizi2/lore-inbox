Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUAFEhB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUAFEhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:37:00 -0500
Received: from coffee.creativecontingencies.com ([210.8.121.66]:61896 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S266137AbUAFEgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:36:50 -0500
Subject: Re: KM266/VT8235, USB2.0 and problems
From: Peter Lieverdink <peter@cc.com.au>
To: linux-kernel@vger.kernel.org
Cc: lk@rekl.yi.org
In-Reply-To: <Pine.LNX.4.58.0401052145520.32347@rekl.yi.org>
References: <Pine.LNX.4.58.0401042314160.18200@rekl.yi.org>
	 <20040105081226.GA14177@kroah.com>
	 <Pine.LNX.4.58.0401051045270.30821@rekl.yi.org>
	 <20040105172306.GB21531@kroah.com>
	 <Pine.LNX.4.58.0401052145520.32347@rekl.yi.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rCCsQqa1XUJhgWRHY3qg"
Message-Id: <1073363798.7647.7.camel@kahlua>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 06 Jan 2004 15:36:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rCCsQqa1XUJhgWRHY3qg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-06 at 14:52, lk@rekl.yi.org wrote:
> > > > Do the errors go away if you stop using devfs?
> > >=20
>=20
> Ok, I removed devfs support from the kernel, and installed udev on the=20
> machine.  I get the same error:
>=20
> SCSI error : <0 0 0 0> return code =3D 0x70000
> end_request: I/O error, dev sda, sector 7552
> Buffer I/O error on device sda, logical block 944

I get the same thing using USB2 on a KT400/VT8235 mobo. I have a 20Gb
USB2 HDD (fat32), which produces this when accessed:

SCSI error : <1 0 0 0> return code =3D 0x8000000
Current sdb: sense key No Sense
end_request: I/O error, dev sdb, sector 19159735
Buffer I/O error on device sdb1, logical block 19159672

The drive works flawlessly with Windows and MacOS. A 128Mb USB key via
USB1.1 causes no problems. Not using udev, not using devfs. The USB2
drive works fine under 2.4.X as well.

- Peter.

--=-rCCsQqa1XUJhgWRHY3qg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/+jtWf34AjKyA6C4RAsW8AKD2W+1glWfNR8lD6mYTmvST9Y6Y5ACdE+lx
xg6pNSZ8mMqN7VqWaNEQ1wA=
=2gWC
-----END PGP SIGNATURE-----

--=-rCCsQqa1XUJhgWRHY3qg--

