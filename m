Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271616AbTGRL6C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 07:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271596AbTGRL6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 07:58:02 -0400
Received: from gate.in-addr.de ([212.8.193.158]:16617 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S271616AbTGRL5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 07:57:48 -0400
Date: Fri, 18 Jul 2003 14:12:02 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4).
Message-ID: <20030718121202.GC6520@marowsky-bree.de>
References: <B179AE41C1147041AA1121F44614F0B0598B10@AVEXCH02.qlogic.org> <20030718122304.A23013@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20030718122304.A23013@infradead.org>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2003-07-18T12:23:04,
   Christoph Hellwig <hch@infradead.org> said:

>  - the driver still has multipath support in the lowlevel driver which
>    we don't want in Linux

Fully agreed.

Please come and attend the multipath session at the Kernel Summit and/or
the Ottawa Linux Symposium next week to learn why this is a bad idea and
how it can be done better -> http://www.linuxsymposium.org/

However, for backwards compatibility with 2.4, I assume it might still
be needed in 2.5/2.6, but _only_ with the clear intend of phasing it out
within 2.6 and dropping it in 2.7.

QLogic is reasonably good already in that it can be disabled via a
module parameter (ql2xfailover=3D0), allowing the higher level solutions
to operate.


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
SuSE Labs - Research & Development, SuSE Linux AG
 =20
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/F+QSudf3XQV4S2cRAnaMAJ9iiRlEjGxYhHHd5L/Avm0gvrLyfwCfdtnn
NP5s+1mqfZjWlx248F6Jrbw=
=sB0m
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
