Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbRFFKrC>; Wed, 6 Jun 2001 06:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbRFFKqv>; Wed, 6 Jun 2001 06:46:51 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:22170 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S261594AbRFFKqj>; Wed, 6 Jun 2001 06:46:39 -0400
Date: Wed, 6 Jun 2001 11:46:33 +0100
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org, Axel Boldt <axel@uni-paderborn.de>,
        Phil Blundell <Philip.Blundell@pobox.com>
Subject: Re: [PATCH] Configure.help:
Message-ID: <20010606114633.H26782@redhat.com>
In-Reply-To: <20010606122434.B859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010606122434.B859@localhost.localdomain>; from remi@a2zis.com on Wed, Jun 06, 2001 at 12:24:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 06, 2001 at 12:24:34PM +0200, Remi Turk wrote:

> Attached is a patch for 2.4.6-pre1 which fixes the help text.

Thanks.

> Also, shouldn't CONFIG_LP_CONSOLE depend on CONFIG_PRINTER=y?  (it
> doesn't work when CONFIG_PRINTER=m, at least for me)

It works for me with CONFIG_PRINTER=m.  You need to have booted the
kernel with the appropriate console= arguments, though.  Also, you
can't unload the module afterwards (the code should be changed to
allow that).

Tim.
*/

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7HgoIONXnILZ4yVIRAgwHAJ0VKiFhWapgK510P89CWLf+CNuiPgCdEnE/
FwG4hrsxA1mNN7jRtpgq0ds=
=HSGQ
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
