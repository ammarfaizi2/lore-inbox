Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268980AbRG3Prj>; Mon, 30 Jul 2001 11:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268982AbRG3Pr3>; Mon, 30 Jul 2001 11:47:29 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:30532 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S268980AbRG3PrR>; Mon, 30 Jul 2001 11:47:17 -0400
Date: Mon, 30 Jul 2001 17:46:53 +0200
From: Kurt Garloff <garloff@suse.de>
To: Michael <leahcim@ntlworld.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        Daniela Engert <dani@ngrt.de>
Subject: Re: VIA KT133A / athlon / MMX
Message-ID: <20010730174653.D4859@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Michael <leahcim@ntlworld.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Daniela Engert <dani@ngrt.de>
In-Reply-To: <20010729222830.A25964@pckurt.casa-etp.nl> <20010730125012Z268576-720+7896@vger.kernel.org> <20010730154458.C4859@pckurt.casa-etp.nl> <20010730151538.A5600@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <20010730151538.A5600@debian>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

thanks for your comments!

On Mon, Jul 30, 2001 at 03:15:38PM +0100, Michael wrote:
> > > On Sun, 29 Jul 2001 22:28:30 +0200, Kurt Garloff wrote:
> > > [54:6]=3DProbe Next Tag State T1	0=3Ddisable   1=3Denable
> >=20
> > Main suspect. (Should be 0)
>=20
> That's set in my stable kt133a system.

But did you experience problems at all with your kernel when compiled for
K7? Note that most (if not all) systems seem to work stable with K6 or PPro
optimized kernels.

> > > [54:0]=3DFast Write-to-Read	0=3Ddisable   1=3Denable
> >=20
> > Third candidate. (Should be 0)
>=20
> as is this one.
> =20
> > > [68:2]=3DBurst Refresh(4 times)	0=3Ddisable   1=3Denable
> >=20
> > Fourth candidate (Should be 0?)
>=20
> I set this one yesterday to see if it would trigger the problem, it
> didn't :o/ Same with a few differences between my system and 0x6b, which
> didn't either.
>=20
> Out of curiosity, where are you getting the 'should be 0/1' details from?

Comparing the lspci -vxxx output of working and non-working systems.

You did no comment on the second candidate:

> [68:4]=3DDRAM Data Latch Delay  0=3DLatch     1=3DDelay latch

Second candidate (Should be 1)

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZYFtxmLh6hyYd04RAhVMAKCtC8zMEStpC0kGF8jAIQw9/FxqzACdEiJ2
stAxKz2uVMUvWhh4D+bdI5E=
=PF9X
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
