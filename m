Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262734AbTDAScg>; Tue, 1 Apr 2003 13:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262739AbTDAScg>; Tue, 1 Apr 2003 13:32:36 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:21764 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262734AbTDASca>; Tue, 1 Apr 2003 13:32:30 -0500
Date: Tue, 1 Apr 2003 20:43:48 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Daniel Egger <degger@fhm.edu>
Cc: David Wuertele <dave-gnus@bfnet.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: flash as hda causes 2.4.18 to hang in grok_partitions()...add_to_page_cache_unique()
Message-ID: <20030401184348.GB3736@arthur.home>
References: <m3smt3xuo1.fsf@bfnet.com> <1049212755.7628.5.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
In-Reply-To: <1049212755.7628.5.camel@localhost>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2003 at 05:59:16PM +0200, Daniel Egger wrote:
> Am Mon, 2003-03-31 um 20.22 schrieb David Wuertele:
>=20
> > I've got a mipsel linux 2.4.18 system that has a compact flash IDE
> > disk as hda.  For some reason, in grok_partitions, the kernel goes
> > bye-bye.  I've traced it as far as read_page_cache().
>=20
> I'd say this is a platform specific bug as it works for me under 2.4.18
> on ppc and i386.

It usually is a CF bug. I've seen failing CF cards on one machine which
work perfectly well in another machine. Just try the same card in
another machine, or a get a new card. I haven't tried it with the new
IDE code, though.


Erik

--=20
J.A.K. (Erik) Mouw
Email: J.A.K.Mouw@its.tudelft.nl  mouw@nl.linux.org

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+id3k/PlVHJtIto0RApzUAKCKL/pvyYIQshETnmy6uLPbodmQxwCgilYw
vhPc0WD+HWz5oeZzMI2K7lY=
=WH5a
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
