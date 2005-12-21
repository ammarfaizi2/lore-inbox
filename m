Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVLUIbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVLUIbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 03:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLUIbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 03:31:37 -0500
Received: from smtp04.auna.com ([62.81.186.14]:38339 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S932330AbVLUIbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 03:31:36 -0500
Date: Wed, 21 Dec 2005 09:34:18 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA SCSI device numbering - I'm confuzed! - Help!
Message-ID: <20051221093418.1e15e5f2@werewolf.auna.net>
In-Reply-To: <43A901C8.4090706@perkel.com>
References: <43A901C8.4090706@perkel.com>
X-Mailer: Sylpheed-Claws 1.9.100cvs95 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_9/Z4ocHgi.WNx.ASVGW/eUv";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Wed, 21 Dec 2005 09:31:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_9/Z4ocHgi.WNx.ASVGW/eUv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Dec 2005 23:18:32 -0800, Marc Perkel <marc@perkel.com> wrote:

> OK - this really has me stumped. I have a asus A8N-SLI premium=20
> motherboard. It has 4 SATA ports on it. The ports are numbered 1 to 4.=20
> So somehow I asumed that port 1 would be /dev/sda ... port 4 would be=20
> /dev/sdd - but when I boot up the order is very different and doesn't=20
> make a lot of sense. How can a person predict what drives will get what=20
> device names. Sure would be handy to be able to know that.
>=20

Plz, post this info:

lspci
dmesg

to see what is in you mobo and how does kernel detect it.
That four sata ports can be several (2?) separate PCI devices and it all de=
pends
on the order the kernel detects them.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam5 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_9/Z4ocHgi.WNx.ASVGW/eUv
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDqROKRlIHNEGnKMMRAkURAJ9OuqbvdpUVQ6IRrxXfKa9LAioKZwCghli9
tWm1DfF9EFeaNOmVTr3E92M=
=GVSn
-----END PGP SIGNATURE-----

--Sig_9/Z4ocHgi.WNx.ASVGW/eUv--
