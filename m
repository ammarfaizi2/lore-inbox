Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbUJYTFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbUJYTFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUJYTEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:04:02 -0400
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:37250 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261263AbUJYTDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:03:30 -0400
Subject: Re: 2.6.9-mm1: LVM stopped working
From: Christophe Saout <christophe@saout.de>
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: linux-kernel@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>
In-Reply-To: <87oeitdogw.fsf@barad-dur.crans.org>
References: <87oeitdogw.fsf@barad-dur.crans.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qvNhs+t5AjpU1BHRj6IT"
Date: Mon, 25 Oct 2004 21:03:22 +0200
Message-Id: <1098731002.14877.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qvNhs+t5AjpU1BHRj6IT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sonntag, den 24.10.2004, 01:06 +0200 schrieb Mathieu Segaud:

> Well, I gave a try to last -mm tree. The bot seemed good till it got to
> LVM stuff. Vgchange does not find any volume groups. I can't say much bec=
ause
> lvm is pretty "early stuff" on this box; so it is pretty unusable. All I =
know
> for now, as I changed a little my boot scripts to be more verbose, is tha=
t
> vgchange -avvv y returns this kind of message:=20
> hdXN: cannot read LABEL
> and this message for all parts it can test....
> As I need this box up and running, I came back to 2.6.9-rc3-mm3 (it works
> pretty well). I will be able to run more tests on it, tomorrow but for no=
w
> that's all I can provide.
>=20
> Oh and dmesg didn't have any oops or BUG in it, and seemed quite usual,
> in IDE detection and settings messages and device-mapper messages.
>=20
> However, I use dm-crypt to encrypt my / (no initrd, just initramfs) and
> it works under 2.6.9-mm1, so the bug is likely to be in IDE stuff.

Are you encrypting your PV or your LVs?

There's some new dm-crypt code in -mm1 along with some API changes, but
backward compatibility is provided and should work.


--=-qvNhs+t5AjpU1BHRj6IT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBfU36ZCYBcts5dM0RAv/CAKCnytz87e+A6+Nt5Ok0nMfqP5d5CACgp2vH
O7PyM4ApFyL49iyH298mxiU=
=xEaT
-----END PGP SIGNATURE-----

--=-qvNhs+t5AjpU1BHRj6IT--

