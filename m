Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUIPQfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUIPQfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268229AbUIPQfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:35:07 -0400
Received: from voicebook.com ([128.121.231.235]:34321 "EHLO voicebook.com")
	by vger.kernel.org with ESMTP id S268180AbUIPQ3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:29:55 -0400
Subject: Re: device driver for the SGI system clock, mmtimer
From: Marcello Barnaba <marcello@softmedia.info>
Reply-To: marcello@softmedia.info
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, Bob Picco <Robert.Picco@hp.com>,
       venkatesh.pallipadi@intel.com
In-Reply-To: <200409160909.12840.jbarnes@engr.sgi.com>
References: <200409161003.39258.bjorn.helgaas@hp.com>
	 <200409160909.12840.jbarnes@engr.sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dLWZTAsN1hceH+GbTo80"
Organization: Softmedia S.c.r.l.
Message-Id: <1095352174.1659.2.camel@nowhere.openssl.softmedia.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Sep 2004 18:29:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dLWZTAsN1hceH+GbTo80
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-16 at 18:09, Jesse Barnes wrote:
> I think Christoph already looked at that.  And HPET doesn't provide mmap=20
> functionality, does it?  I.e. allow a userspace program to dereference th=
e=20
> counter register directly?

drivers/char/Kconfig:

config HPET_MMAP
        bool "Allow mmap of HPET"
        default y
        depends on HPET
        help=20
          If you say Y here, user applications will be able to mmap
          the HPET registers.

          In some hardware implementations, the page containing HPET
          registers may also contain other things that shouldn't be
          exposed to the user.  If this applies to your hardware,
          say N here.
--=20
Marcello Barnaba - SoftMedia S.c.r.l.    ::    Mobile: +39 (340) 3698342
Via Mauro Amoruso, 11 - 70124 Bari       ::    Phone:  +39 (080) 5046314
pub 1024D/F04476A2 :: 6807 EEA5 7F97 AC9A D8EF  AE73 64CD 71A2 F044 76A2

--=-dLWZTAsN1hceH+GbTo80
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBSb9ukn504uXeT8sRArnqAJ9R+1abAb0PL4jgnCvkTAtOZvoPCgCfZK++
Fr1PFHoBXSKUm4ZH6hiIJc4=
=zYi8
-----END PGP SIGNATURE-----

--=-dLWZTAsN1hceH+GbTo80--
