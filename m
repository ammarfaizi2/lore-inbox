Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbTAZRTZ>; Sun, 26 Jan 2003 12:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266851AbTAZRTZ>; Sun, 26 Jan 2003 12:19:25 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:54146 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP
	id <S266840AbTAZRTY>; Sun, 26 Jan 2003 12:19:24 -0500
Date: Sun, 26 Jan 2003 17:28:37 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: sundara raman <sundararamand@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: doubts in INIT - while system booting up
Message-ID: <20030126172837.GA1196@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	sundara raman <sundararamand@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20030126170034.30209.qmail@web20507.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20030126170034.30209.qmail@web20507.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 26, 2003 at 09:00:34AM -0800, sundara raman wrote:

> 8) while system booting up, it shows the following
> error
> 
> 	 INIT: Id "x" respawing too fast: disabled for 5
> minutes

   It's not a kernel problem -- there's something broken in your X
Windows configuration. xdm (or kdm or gdm) keeps trying to start and
fails, and init is restarting it, and it fails...

   Take a look in your X logs (I run Debian and mine are in
/var/log/XFree86.log.0 -- yours may be somewhere else) for the cause
of X not starting.

   Hope this helps,
   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
              --- w.w.w.  : England's batting scorecard ---              

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+NBrFssJ7whwzWGARAtFKAJ9ZMN4X+YU6hWfd8he5bMUvtarHFwCgslNm
GTuZ/r5vbOI+dtZtLLOUuIM=
=LzRr
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
