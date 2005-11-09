Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVKIVNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVKIVNk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVKIVNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:13:40 -0500
Received: from smtp06.auna.com ([62.81.186.16]:2043 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1751362AbVKIVNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:13:39 -0500
Date: Wed, 9 Nov 2005 22:12:58 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Chris Boot <bootc@bootc.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm1 RAID-1 in D< state
Message-ID: <20051109221258.3bd5cd77@werewolf.auna.net>
In-Reply-To: <4371FA5B.6030900@bootc.net>
References: <4371FA5B.6030900@bootc.net>
X-Mailer: Sylpheed-Claws 1.9.100cvs4 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_wwfJ++XHyM2a/Xw8uVtn/D8";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.199] Login:jamagallon@able.es Fecha:Wed, 9 Nov 2005 22:13:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_wwfJ++XHyM2a/Xw8uVtn/D8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Nov 2005 13:32:11 +0000, Chris Boot <bootc@bootc.net> wrote:

> Hi all,
>=20
> I haven't noticed this until today...but my load average has been=20
> skyrocketing past 3.00 since Monday, which is when I upgraded to=20
> 2.6.14-mm1. I've got 3 Software RAID-1 arrays across 4 SATA disks, and=20
> all 3 processes are locked in an uninterruptible sleep.
>=20
> What's interesting, though, is I haven't noticed a degradation of=20
> performance at all, and all the arrays work absolutely fine. They aren't=
=20
> rebuilding or doing anything strange that I can see.
>=20
> Any ideas?
>=20

Try this:

http://marc.theaimsgroup.com/?l=3Dlinux-scsi&m=3D113145981728205&w=3D2

My raid 5 was oopsing till I applied this.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_wwfJ++XHyM2a/Xw8uVtn/D8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDcmZaRlIHNEGnKMMRAmWBAKCYDXhjKXMfkYd6o8WXKaWx9tkrOACfXxl6
n/u9uSVxst1EoCzjHzXkCe8=
=jiwV
-----END PGP SIGNATURE-----

--Sig_wwfJ++XHyM2a/Xw8uVtn/D8--
