Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbULaSXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbULaSXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 13:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbULaSXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 13:23:07 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:54452 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262134AbULaSWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 13:22:35 -0500
Date: Fri, 31 Dec 2004 20:22:34 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: pmarques@grupopie.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sh: inconsistent kallsyms data
Message-ID: <20041231182234.GB18211@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	pmarques@grupopie.com, linux-kernel@vger.kernel.org
References: <20041231172549.GA18211@linux-sh.org> <1104515971.41d593835721f@webmail.grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <1104515971.41d593835721f@webmail.grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 31, 2004 at 05:59:31PM +0000, pmarques@grupopie.com wrote:
> I think the only change from 2.6.9 that could affect this is the
> addition of the is_arm_mapping_symbol from Russel King.
>=20
This wouldn't make any difference as that only gets invoked by
read_symbol() for U type symbols, which is unrelated.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB1Zjq1K+teJFxZ9wRArUPAJ4k5V1oNxx48Va1rYI1ov9OHEcc2QCeOzsx
cK6U+JjFsX/lYIOZhB4QVwM=
=39lF
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
