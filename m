Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266304AbUJNQAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUJNQAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUJNQAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 12:00:17 -0400
Received: from hydra.gt.owl.de ([195.71.99.218]:59340 "EHLO hydra.gt.owl.de")
	by vger.kernel.org with ESMTP id S266304AbUJNQAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 12:00:08 -0400
Date: Thu, 14 Oct 2004 17:43:19 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.7] kernel BUG at fs/jbd/transaction.c:1227!
Message-ID: <20041014154319.GH21334@paradigm.rfc822.org>
References: <20040906204135.GA9240@paradigm.rfc822.org> <1094502324.4531.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline
In-Reply-To: <1094502324.4531.12.camel@localhost.localdomain>
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 06, 2004 at 09:25:26PM +0100, Alan Cox wrote:
> On Llu, 2004-09-06 at 21:41, Florian Lohoff wrote:
> > Sep  6 20:22:03 source kernel: attempt to access beyond end of device
> > Sep  6 20:22:03 source kernel: sdb1: rw=3D0, want=3D1803231528, limit=
=3D976784067
> > Sep  6 20:22:03 source kernel: attempt to access beyond end of device
> > Sep  6 20:22:03 source kernel: sdb1: rw=3D0, want=3D1080256520, limit=
=3D976784067
> > Sep  6 20:22:03 source kernel: attempt to access beyond end of device
> > Sep  6 20:22:03 source kernel: sdb1: rw=3D0, want=3D1121190792, limit=
=3D976784067
> > Sep  6 20:22:03 source kernel: attempt to access beyond end of devic
>=20
> All of these seem to be sensible block numbers if the top bit is flipped
> back.  How much do you trust the hardware ?

Too much - It seems there is a 3Ware HW bug notice saying that for
64Bit 3Ware Controllers on specific Board and or Chipsets (My case
I7501) there are some unwanted noises on the PCI lines which is fixed in
newer Board revisions of the Controllers.

After replacing the 8506 with a newer revision the bug is gone.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBbp6WUaz2rXW+gJcRAhHMAKCWE+3Gtd+ERHCij03DF/RfpxL1zQCeI/Sw
F1azh9ydqC9ujXYjlAGHJdQ=
=svof
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
