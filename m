Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289870AbSAKEt0>; Thu, 10 Jan 2002 23:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289872AbSAKEtQ>; Thu, 10 Jan 2002 23:49:16 -0500
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:14756 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S289870AbSAKEtE>; Thu, 10 Jan 2002 23:49:04 -0500
Date: Thu, 10 Jan 2002 23:46:08 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management problems in 2.4.16
Message-ID: <20020111044608.GA26644@opeth.ath.cx>
In-Reply-To: <20020110224036.GA32522@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33L.0201110141090.2985-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0201110141090.2985-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.25i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And on a PII/400 limited to "mem=3D64M", a `dbench 60` running with XMMS
1.2.6 did not cause any noticeable audio breakup. This is on 2.4.17 +
rmap10c + ide.2.4.16.12102001 + Bill's original hashed waitqueues patch.
(I should also add that XMMS was not running with realtime priority.)
I'll see if I can produce some numbers in a bit.

On Fri, Jan 11, 2002 at 01:42:03AM -0200, Rik van Riel wrote:
> I've been running a few hours of low memory testing with
> my rmap VM and it's holding up fine. The system is still
> responsive when the amount of pageable RAM is down to
> about 400 kB ;))

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Pm4QMwVVFhIHlU4RAoy1AJ9cAHOpCBl9JrWIfV7+epBNZsgO4QCfcrFL
cbbLK3jHNAEFo0pX5g0eU5g=
=HNGv
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
