Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUEQWzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUEQWzf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbUEQWzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:55:35 -0400
Received: from legolas.restena.lu ([158.64.1.34]:3752 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263024AbUEQWzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:55:13 -0400
Subject: Re: 2.6.6-xx locks up hard (nforce 2)
From: Craig Bradney <cbradney@zip.com.au>
To: Tim Krieglstein <tstone@fachschaft.informatik.tu-darmstadt.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040517223550.GA7631@host02.fachschaft.informatik.tu-darmstadt.de>
References: <20040517223550.GA7631@host02.fachschaft.informatik.tu-darmstadt.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Kpa4/bGsW0Yn5lFNkbTz"
Message-Id: <1084834509.14114.7.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 18 May 2004 00:55:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Kpa4/bGsW0Yn5lFNkbTz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-05-18 at 00:35, Tim Krieglstein wrote:
> Hi=20
>=20
> I have a serious problem with the newer kernel versions. Every Version
> of 2.6.6((-mm[123])*) locks up hard, no network no pinging no input.
> Just plain noting :(. The systems seems to boot up fine but after a few
> seconds after X has started everything locks up. Currently i am running
> the 2.6.5 version which has been running stable for days. I didn't tried
> the the mm versions of the 2.6.5 flavour (or probably i tested them but
> i forgot...). I know that there are broken out patches available, but
> before starting binary search on the single patches i hope i get an
> educated guess? I have already taken out an rtl8169 network card. But
> still lockups (the cards drivers seemed to be very bogus in earlier
> versions till 2.6.4 or so). Attached there will be the lspci output and
> my kernel config.=20
>=20
> Appendix: Ok, i glanced over the list-archives (i am not subscribed) and
> under the topic "IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=3D1 +
> [PATCH]for idle=3DC1halt, 2.6.5 " seem to be some fixes, i haven't tried
> yet. The thread was spread over different directorys and i didn't get
> the point. However lspci -xxx -vvv gives me the following error:
> pcilib: sysfs_read: tried to read 256 bytes at 0, but got only 64
> lspci: Unable to read 256 bytes of configuration space. Do these fixes
> help me in my problem?
>=20
> System is Debian sid.=20

The IO APIC idle c1 halt patches should work fine on 2.6.5 and stop
nforce related hanging. 2.6.6 is supposed to have the "correct" fix for
the BIOS issues. Perhaps there is something else wrong with the system?
Others will have more input.. Im yet to try 2.6.6 on the nforce system
here due to the IDE caching issues.

Craig

--=-Kpa4/bGsW0Yn5lFNkbTz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAqULNi+pIEYrr7mQRAk1qAKCMbtoN/rH1dRtj46mWjRciY6mMewCgqcKk
ycuh9g7wOBNm9nDXZo0orhA=
=DuKX
-----END PGP SIGNATURE-----

--=-Kpa4/bGsW0Yn5lFNkbTz--

