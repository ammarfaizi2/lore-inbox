Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTLAPjW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 10:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTLAPjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 10:39:22 -0500
Received: from ns.suse.de ([195.135.220.2]:45450 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263591AbTLAPjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 10:39:20 -0500
Date: Mon, 1 Dec 2003 16:39:16 +0100
From: Kurt Garloff <garloff@suse.de>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need help with diagnosing SCSI related (probably hardware?) problem (DC395 driver)
Message-ID: <20031201153916.GV3049@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Oliver Feiler <kiza@gmx.net>, linux-kernel@vger.kernel.org
References: <200311302338.45519.kiza@gmx.net> <200312011208.46576.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZWXK6sTLcF/iWTw"
Content-Disposition: inline
In-Reply-To: <200312011208.46576.kiza@gmx.net>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test11-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE(DE), TU/e(NL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dZWXK6sTLcF/iWTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Oliver,

On Mon, Dec 01, 2003 at 12:08:39PM +0100, Oliver Feiler wrote:
Content-Description: signed data
> CC'ing to Kurt Garloff since he wrote the driver initially and might be t=
he=20
> best person to ask what the syslog output means. Are you still maintainin=
g=20
> the DC395 driver, Kurt, or has someone else taken maintainership in the=
=20
> meantime?

For 2.6, Oliver Neukum and others have picked up the driver.
I maintain the 2.4 version still.

> Small followup to the described problem. I managed to get a "screenshot" =
from=20
> the kernel's syslog output. Indeed the driver is queueing endless SCSI re=
sets=20
> with little success. These two pages (some parts may be missing. Taken wi=
th a=20
> digital camera) scroll over the screen endlessly. Can someone tell me fro=
m=20
> this what's going on and what it is causing the problem?
>=20
> http://home.kcore.de/~kiza/stuff/dc395.jpg
> http://home.kcore.de/~kiza/stuff/dc395-2.jpg
> (both 1024x768 ~100KB)

Hmm, it looks quite normal; the driver is trying to recover from errors.
Apparently the write10 (2a) timed out. Can you try to catch the first
error message?=20

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--dZWXK6sTLcF/iWTw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/y2CkxmLh6hyYd04RAt2NAJ0Ycxmj2r3Xs3z1xIoQMXmj1+IyLQCfapo0
GRHjvMLGtHtMsP/4DXyKYLc=
=9bQs
-----END PGP SIGNATURE-----

--dZWXK6sTLcF/iWTw--
