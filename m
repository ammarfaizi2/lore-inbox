Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132186AbRDFRvS>; Fri, 6 Apr 2001 13:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132194AbRDFRvE>; Fri, 6 Apr 2001 13:51:04 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:24844 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S132186AbRDFRul>; Fri, 6 Apr 2001 13:50:41 -0400
Date: Fri, 6 Apr 2001 19:49:10 +0200
From: Kurt Garloff <garloff@suse.de>
To: Norbert Preining <preining@logic.at>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: gcc oopses with 2.4.3
Message-ID: <20010406194910.J19691@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Norbert Preining <preining@logic.at>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010406174442.A19874@alpha.logic.tuwien.ac.at> <123100000.986572812@tiny> <20010406183303.A20867@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wHh0aNzodMFDTGdO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010406183303.A20867@alpha.logic.tuwien.ac.at>; from preining@logic.at on Fri, Apr 06, 2001 at 06:33:03PM +0200
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wHh0aNzodMFDTGdO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2001 at 06:33:03PM +0200, Norbert Preining wrote:
> On Fre, 06 Apr 2001, Chris Mason wrote:
> > sigbus from gcc usually points to the ram, have you run a tester?
>=20
> But sig 4 is sigill (whatever this may be) and 1ig11 sigsegv, so
> no sigbus!?

Illegal Instruction. Your CPU was reading some machine insn from memory it
never heard about. =3D> exception 6 =3D> signal 4 (SIGILL)

If your main memory is not faulty, it's your cache or your CPU. Or your
compiler.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--wHh0aNzodMFDTGdO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6zgGVxmLh6hyYd04RAusuAJ9Yav0FZQF9Uql8OGxc61yIhX1QwwCeKGtL
z24kvcrdzPlto9BLr5327bo=
=tcjP
-----END PGP SIGNATURE-----

--wHh0aNzodMFDTGdO--
