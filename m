Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUAOO7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 09:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUAOO7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 09:59:55 -0500
Received: from hostmaster.org ([80.110.173.103]:4738 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S264391AbUAOO7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 09:59:53 -0500
Subject: Re: [2.6,2.4] HPT366 (on Abit BP6) + Seagate 7000.7 + DMA = kernel
	halted
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1074103900.22670.27.camel@narsil>
References: <1074103900.22670.27.camel@narsil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jof48GOmJ2OOAsJWvf1h"
Message-Id: <1074178780.1400.34.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 15 Jan 2004 15:59:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jof48GOmJ2OOAsJWvf1h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Must be a problem with the harddisk; I do also have a Abit BP6 board
with two WD800JB which work fine on the HPT366 controller. Maybe you
should try to connect them to one of the PIIX4 IDE channels. Btw: I do
have CONFIG_IDEDMA_PCI_AUTO enabled so I do not even need to use hdparm
to enable DMA.

However I am myself not so sure if I should use the HPT366 or the PIIX4
controller as I got better cache read throughput (hdparm -T) with the
PIIX4 controller and could avoid sharing an interrupt. Maybe someone
here is willing to share some piece of advice?

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
       mail pgp-key-request@hostmaster.org

We are tied to the ocean. And we go back to the sea, whether it is to sail =
or
to watch it we are going back from whence we came. - John F. Kennedy

--=-jof48GOmJ2OOAsJWvf1h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQEVAwUAQAaq12D1OYqW/8uJAQIJ4Qf+MHD1x56h6ZnKdGYY4Iu458YZBRcCspjH
oEM2vj1I52RcVd58gzDGnEo9wURkreDa236yi3I6VjbpTl+1Q8Pi888OroWezz51
9/oHdv+Jt+XJdsT4APwkIcPtAk6wF5kGQRlKnRcFcKx4COQ/LZ1UosVUCxDBgDJ8
g8XTGWpXRBfokHd3CQkT/PDLu4c9/LRaCnwMUEdLQzvPxOaqYB/2e1qktwR9QvWI
yEQjKNtIcDVd8JfUf6bZpgKjeho40edK8zgEyYUSTxuIpbg0tUG4EwsPWpp/rZjv
c4cUeKcBZ8c677TtQUYmHqnZuHEvB/+tFFQ3KPFLQ8blKq/slWFcug==
=sKK5
-----END PGP SIGNATURE-----

--=-jof48GOmJ2OOAsJWvf1h--

