Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130840AbRBWXpr>; Fri, 23 Feb 2001 18:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130867AbRBWXph>; Fri, 23 Feb 2001 18:45:37 -0500
Received: from zeus.kernel.org ([209.10.41.242]:58343 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130840AbRBWXpc>;
	Fri, 23 Feb 2001 18:45:32 -0500
Date: Fri, 23 Feb 2001 17:35:57 -0600
From: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
To: Kevin Turner <acapnotic@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.1] system goes glacial, Reiser on /usr doesn't sync
Message-ID: <20010223173557.A2744@zed.dlitz.net>
In-Reply-To: <20010220021609.B11523@troglodyte.menefee>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010220021609.B11523@troglodyte.menefee>; from acapnotic@users.sourceforge.net on Tue, Feb 20, 2001 at 02:16:09AM -0800
X-Homepage: http://www.dlitz.net/
X-Spam-Policy-URL: http://www.dlitz.net/go/spamoff.shtml
X-PGP-Public-Key-URL: http://www.dlitz.net/gpgkey2.asc
X-PGP-ID-Sign: 0xE272C3C3
X-PGP-Fingerprint-Sign: 9413 0BD2 1030 070E 301E  594F F998 B6D8 E272 C3C3
X-Operating-System: Debian testing/unstable GNU/Linux zed 2.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have the same problem with 2.4.1 (and 2.4.2).  Two processes that are
actively using the disk (multiple files) seem to deadlock the system.  Kill=
ing
the right process (SysRq-K) seems to fix things.

I'm kind of new to kernel debugging.  Anyone want to guide me through it?

=20
--=20
Dwayne C. Litzenberger - dlitz@dlitz.net

- Please always Cc to me when replying to me on the lists.
- See the mail headers for GPG/advertising/homepage information.

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjqW890ACgkQ+Zi22OJyw8N7SQCggaLKQOqsik6qIfjtQ+1v5PlG
a2gAoIInZ/CsB/e8lbv0zUNDm3cp18yr
=YGWz
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
