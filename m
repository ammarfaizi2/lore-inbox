Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262888AbSJRGBT>; Fri, 18 Oct 2002 02:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262897AbSJRGBT>; Fri, 18 Oct 2002 02:01:19 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:22284 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S262888AbSJRGBS>;
	Fri, 18 Oct 2002 02:01:18 -0400
Date: Fri, 18 Oct 2002 10:06:11 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] add support for PC-9800 architecture (20/26) serial #1
Message-ID: <20021018060611.GB3953@pazke.ipt>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20021017204013.A1265@precia.cinet.co.jp> <20021017151125.A3326@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <20021017151125.A3326@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2002 at 03:11:25PM +0100, Russell King wrote:
> I strongly recommend _n_o_t_ merging this patch.

Did you see the next patch (21/26 serial #2) ? It looks even more interesti=
ng.
As I understand serial98.c driver should support older i8251 UART.
However it does it by perverting 8250.c and EMULATING i8250 on top of i8251,
see ugly code in serial_in() and serial_out() functions.

May be I misunderstand the issue, but IMHO this patch is unacceptible too :(

Best regards.
=20
--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9r6TTBm4rlNOo3YgRAiZUAJ9sF74gW11oZOqGTyX/7yyM8DemCwCfXbFb
vJY83kn6D/olOLoDq2VJVh8=
=LsaK
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
