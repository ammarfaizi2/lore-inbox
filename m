Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266693AbSLJHXp>; Tue, 10 Dec 2002 02:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbSLJHXp>; Tue, 10 Dec 2002 02:23:45 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:11278 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S266693AbSLJHXo>;
	Tue, 10 Dec 2002 02:23:44 -0500
Date: Tue, 10 Dec 2002 10:30:21 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Pavel Jan?k <Pavel@Janik.cz>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PCI serial card with PCI 9052?
Message-ID: <20021210073021.GA3051@pazke.ipt>
Mail-Followup-To: Pavel Jan?k <Pavel@Janik.cz>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <m3smxx1aaf.fsf@Janik.cz> <20021120095618.GB319@pazke.ipt> <m3fztrcinh.fsf@Janik.cz> <20021124114307.A25408@flint.arm.linux.org.uk> <m3vg2naupr.fsf@Janik.cz> <20021125094828.GA6016@pazke.ipt> <m3hee55qc6.fsf@Janik.cz> <20021201110202.E24114@flint.arm.linux.org.uk> <m3vg22pd19.fsf@Janik.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <m3vg22pd19.fsf@Janik.cz>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2002 at 08:07:46AM +0100, Pavel Jan?k wrote:

[snip]

> On the other hand, that card worked only with "IRQ" 0, ie. polling. We
> could not got it running with the IRQ the PCI bus told us (there was only
> one PCI card in the machine, no peripherals, no interrupt conflict...).

Looks like this card needs special PLX related magic to work with interrupt=
s.
Can you try to set pci_plx9050_fn() as init function for this card ?
=20
--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE99ZgNBm4rlNOo3YgRAlsOAJ0fEzTclIGXOyTZs4s+JqJ7K4keaACeNunt
f0/CphJ2exhzEt2z+oap9AE=
=Vq80
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
