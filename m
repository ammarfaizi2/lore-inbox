Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTJUAjX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 20:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTJUAjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 20:39:23 -0400
Received: from wblv-241-59.telkomadsl.co.za ([165.165.241.59]:35714 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262901AbTJUAjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 20:39:08 -0400
Subject: Re: [ANNOUNCE] udev 003 release
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Greg KH <greg@kroah.com>
Cc: clemens@dwf.com, linux-hotplug-devel@lists.sourceforge.net,
       KML <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
In-Reply-To: <20031017182754.GA10714@kroah.com>
References: <20031017055652.GA7712@kroah.com>
	 <200310171757.h9HHvGiY006997@orion.dwf.com>
	 <20031017181923.GA10649@kroah.com>  <20031017182754.GA10714@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-92N1f9R6uFrmRMiAwRRL"
Message-Id: <1066696767.10221.164.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 21 Oct 2003 02:39:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-92N1f9R6uFrmRMiAwRRL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-10-20 at 12:07, Greg KH wrote:
> On Fri, Oct 17, 2003 at 11:19:23AM -0700, Greg KH wrote:
> >=20
> > Ah, yeah, udev seg faults right now for partitions.  Let me try to trac=
k
> > down the bug, give me a bit of time...
>=20
> Here's a patch that fixes the partition logic for me.  Sorry about this, =
I
> need to make sure to test partitions more next time.
>=20

This works fine for me, thanks.

Three questions if you do not mind:

1)  Is it possible to maintain naming of tarball/version ?  Meaning,
    say we forget about the 003 version, could the next be 0.4, or even
    0.3.1 or whatever ?  Just changing makes trying to keep packages
    sane a hassle.  Thanks :)

2)  Is the libsysfs included later than that in sysfsutils-0_2_0.tar.gz?
    If not, any idea if/when udev will start following official
    libsysfs?  Yes, not a biggie, but it would be nice to have
    sysfsutils its own package :)

3)  Any plans to have namedev support wildcarts ?  Like:

  dsp*:root:audio:0660
  audio*:root:audio:0660
  midi*:root:audio:0660
  mixer*:root:audio:0660


Thanks!

--=20

Martin Schlemmer




--=-92N1f9R6uFrmRMiAwRRL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/lIA/qburzKaJYLYRAhHhAJ9u5AOLah7GRusK9Z3Zc4UrJAwPagCghGhN
anOkuLvKbr177VqsvdQ4kKI=
=JRW9
-----END PGP SIGNATURE-----

--=-92N1f9R6uFrmRMiAwRRL--

