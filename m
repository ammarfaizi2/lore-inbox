Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVJEU6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVJEU6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVJEU6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:58:01 -0400
Received: from [63.227.222.140] ([63.227.222.140]:44207 "EHLO
	smtp.omgwallhack.org") by vger.kernel.org with ESMTP
	id S1750832AbVJEU6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:58:00 -0400
Date: Wed, 5 Oct 2005 13:57:04 -0700
From: Julian Blake Kongslie <jblake@omgwallhack.org>
To: Bas Westerbaan <bas.westerbaan@gmail.com>
Cc: Marc Perkel <marc@perkel.com>, 7eggert@gmx.de,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005135704.4c1ac407@kolionychia.omgwallhack.org>
In-Reply-To: <6880bed30510051351ja5bd5dfo5fbec9514a5cbdd7@mail.gmail.com>
References: <4TiWy-4HQ-3@gated-at.bofh.it>
	<4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz>
	<43443723.907@perkel.com>
	<20051005134109.757a5e42@kolionychia.omgwallhack.org>
	<6880bed30510051351ja5bd5dfo5fbec9514a5cbdd7@mail.gmail.com>
Organization: Fists of Righteous Harmony
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Pretention: High
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Wed__5_Oct_2005_13_57_04_-0700_Buu0ZDYfRcJK_EWA;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__5_Oct_2005_13_57_04_-0700_Buu0ZDYfRcJK_EWA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Oct 2005 22:51:32 +0200
Bas Westerbaan <bas.westerbaan@gmail.com> wrote:

> You can delete a directory entry to a file if you have proper
> permission to the directory.
>=20
> You cannot read or write the file if the file doesn't give you
permission to.
>=20
> A hard link makes an additional directory entry to a certain file. You
> delete the directory entry to the file, not the file.
>=20
> And permissions are the same for all instances of the file.
>=20
> My 2 cents.

That is the UNIX model, yes. And I think it makes perfect sense. And as
a side effect, we can delete links to files which we do not own, and
cannot write to.

Does NetWare have an equivalent of hardlinks?

--=20
-Julian Blake Kongslie
<jblake@omgwallhack.org>

--Signature_Wed__5_Oct_2005_13_57_04_-0700_Buu0ZDYfRcJK_EWA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Don't have my public key? Email <jblake@omgwallhack.org> and I'll gladly mail it to you.

iD8DBQFDRD4luU009xtCYDURAmhJAKCJNKtr1TIB5O/+w5Va4F2XrTEOiwCZAeV4
XBlMDyMD0tcsw68zFkKgvJQ=
=wtRG
-----END PGP SIGNATURE-----

--Signature_Wed__5_Oct_2005_13_57_04_-0700_Buu0ZDYfRcJK_EWA--
