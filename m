Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVGZTaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVGZTaO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVGZTaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:30:08 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:16272 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261882AbVGZR0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:26:00 -0400
Date: Tue, 26 Jul 2005 18:58:34 +0200
From: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
To: lkml@vger.kernel.org
Message-Id: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__26_Jul_2005_18_58_34_+0200_ViwyhiH7UdB/=7hS"
Subject: MM kernels - how to keep on the bleeding edge?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__26_Jul_2005_18_58_34_+0200_ViwyhiH7UdB/=7hS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've a question on how to keep in touch with all those patches going into mm
patchset. Yes, I know of and am subscribed to mm-commits list, but it has a
few shortcomings:=20
a) It doesn't tell which patches went into the mainline.
That's not necessary, as there's always git, but comparing on commit messag=
es
seems awkward and the contents aren't necessarily the same.

Maybe AM has some algorithm to determine which patches went in and which,
say, went in only in part?=20
Or that he redoes all the patches against the newest Linus' tree?
Anyway, I'd like to know what was the tree version at the time.

b) It doesn't say which -mm version are they in.
This is a real PITA, because I have to check patch list one after one to
apply to the newest mm. A message consisting of:=20

Subject: 2.6.x-mmy released

Contains all patches up to:
 abc-fix.patch

Is based on Linus' tree up to commit:
  xyzabc123

would be more than enough.
This way it would be easy to update the latest patchset to the latest and
(hopefully) greatest mailing list patch. As it is now, I have to do a search
every time I blow up the tree.

It would be much easier for me if there was a mercurial or git tree with mm
patches available somewhere, but I can live with my mail reading script.

(I'm not subscribed to the list at the time - my mailbox would blow up)

--=20
AstralStorm

GPG Key ID =3D 0xD1F10BA2
GPG Key fingerprint =3D 96E2 304A B9C4 949A 10A0  9105 9543 0453 D1F1 0BA2
Please encrypt if you can.

--Signature=_Tue__26_Jul_2005_18_58_34_+0200_ViwyhiH7UdB/=7hS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQFC5mvClUMEU9HxC6IRAoYuAJ0bMQdLqp1AtkguxsjifixpAJOEEACgomix
EkAu/StTgYKEKuLe7mAzG88=
=bTgq
-----END PGP SIGNATURE-----

--Signature=_Tue__26_Jul_2005_18_58_34_+0200_ViwyhiH7UdB/=7hS--
