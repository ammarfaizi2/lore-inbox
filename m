Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVLFKbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVLFKbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVLFKbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:31:37 -0500
Received: from mivlgu.ru ([81.18.140.87]:17367 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964944AbVLFKbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:31:36 -0500
Date: Tue, 6 Dec 2005 13:31:30 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Organov <osv@javad.com>, linux-kernel@vger.kernel.org
Subject: Re: SATA ICH6M problems on Sharp M4000
Message-ID: <20051206103129.GA18233@master.mivlgu.local>
References: <87u0dri996.fsf@javad.com> <20051205202228.13232c10.vsu@altlinux.ru> <874q5nfm1e.fsf@javad.com> <439484EC.5080406@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <439484EC.5080406@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2005 at 01:20:28PM -0500, Jeff Garzik wrote:
> Sergei Organov wrote:
> >Sergey Vlasov <vsu@altlinux.ru> writes:
> >>See http://lkml.org/lkml/2005/10/18/167 and the reply to it :-\
> >
> >Well, Jef's answer was:
> >
> >  This is a reasonable point, but the rare person who runs modular IDE o=
n=20
> >  these PATA/SATA combined mode beasts can certainly tell the IDE driver=
=20
> >  to not probe certain ports.
> >
> >I can say that the kernel I have problem with is from Debian "testing"
> >distribution so those "rare person" going to become quite a few in the
> >near future. Besides, Debian loads ata_piix first, then IDE, so telling
> >the IDE to ignore certain ports won't help.

mkinitrd in ALT Linux has some hacks to detect driver type (IDE or SCSI
subsystem) and load all IDE drivers before SCSI - exactly for this reason.

> >Though one can argue that that's yet another distribution problem, I
> >fail to see a way for a distribution to overcome the problem provided it
> >doesn't know the exact hardware it will run on. No hope for modularized
> >kernel to run out of the box on given hardware?
> >
> >Jeff, is there any hope it will be fixed in the kernel.org sources, or
> >should I report the problem to Debian instead so that they consider
> >maintaining their own patch?
>=20
> Debian doesn't need to maintain a patch, they should load modules in the=
=20
> proper order.

This will not help - without my patch the combined mode support code is
not compiled if IDE is modular.

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDlWiBW82GfkQfsqIRAmSPAKCSLbu3TSKTVD9XnL61K0VPAiZHrQCeMjLg
RyzPGqJ5wVGvwLkQ5rvrcoY=
=eSHv
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
