Return-Path: <linux-kernel-owner+w=401wt.eu-S932810AbWLSMe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbWLSMe6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbWLSMe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:34:58 -0500
Received: from nucleus.hjsoft.com ([207.210.221.102]:1395 "EHLO
	nucleus.hjsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810AbWLSMe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:34:57 -0500
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 07:34:57 EST
Date: Tue, 19 Dec 2006 07:24:47 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: linux-kernel@vger.kernel.org
Subject: forcedeth trouble in 2.6.19(.1)
Message-ID: <20061219122447.GA23367@hjsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I saw a mention of interrupt handling for forcedeth cards is the
2.6.19.1 changelog, but I still see this error in 2.6.19.1.  It started
in 2.6.19, and it didn't happen in 2.6.18.1.

Dec 17 05:35:29 butterfly kernel: [184432.371636] eth3: Tx timed out,
lost interrupt? TSR=3D0x3, ISR=3D0x97, t=3D2222.
Dec 17 05:35:31 butterfly kernel: [184433.370864] NETDEV WATCHDOG: eth3:
transmit timed out
Dec 17 05:35:31 butterfly kernel: [184433.370871] eth3: Tx timed out,
lost interrupt? TSR=3D0x3, ISR=3D0x3, t=3D1190.
Dec 17 05:35:34 butterfly kernel: [184434.869718] NETDEV WATCHDOG: eth3:
transmit timed out
Dec 17 05:35:34 butterfly kernel: [184434.869725] eth3: Tx timed out,
lost interrupt? TSR=3D0x3, ISR=3D0x3, t=3D1189.
Dec 17 05:35:37 butterfly kernel: [184436.368072] NETDEV WATCHDOG: eth3:
transmit timed out
Dec 17 05:35:37 butterfly kernel: [184436.368080] eth3: Tx timed out,
lost interrupt? TSR=3D0x3, ISR=3D0x97, t=3D2189.
Dec 17 05:35:39 butterfly kernel: [184437.367308] NETDEV WATCHDOG: eth3:
transmit timed out
Dec 17 05:35:39 butterfly kernel: [184437.367315] eth3: Tx timed out,
lost interrupt? TSR=3D0x3, ISR=3D0x3, t=3D1188.

Is this the same issue?  Thanks.
--=20
John M Flinchbaugh
john@hjsoft.com

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFh9oPCGPRljI8080RAl3zAJ0QNWn5xMEMkhSTg5izquyh09u+TgCeNfxs
8tiAH7h7xrl202T3Lc/Y4Do=
=YjvX
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
