Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVIXMOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVIXMOj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 08:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVIXMOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 08:14:39 -0400
Received: from fuzznuts.plus.net ([212.159.14.133]:37550 "EHLO
	pih-relay06.plus.net") by vger.kernel.org with ESMTP
	id S932166AbVIXMOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 08:14:38 -0400
Date: Sat, 24 Sep 2005 13:14:31 +0100
From: Chris Sykes <chris@sigsegv.plus.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-ID: <20050924121431.GA5530@sigsegv.plus.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <20050922163708.GF5898@sigsegv.plus.com> <20050923015719.5eb765a4.akpm@osdl.org> <20050923121932.GA5395@sigsegv.plus.com> <20050923132216.GA5784@sigsegv.plus.com> <20050923121811.2ef1f0be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20050923121811.2ef1f0be.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2005 at 12:18:11PM -0700, Andrew Morton wrote:
> That would be ideal, thanks.  Grab the latest from
> http://www.kernel.org/pub/software/scm/git/ and take a look at
> Documentation/git-bisect-script.txt

OK

After many compile reboot cycles, git-bisect tells me that the
offending cset is 10f47e6a1b8b276323b652053945c87a63a5812d:
    [PATCH] ext2: Enable atomic inode security labeling

I'll do some more testing to verify.

--=20

(o-  Chris Sykes
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt
GPG Fingerprint: 5E8E D17F F96C CC08 911D  CAF2 9049 70D8 5143 8090

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDNUMnkElw2FFDgJARAqXvAKDMq4jMzHTE75EwQkm5JPlALAqzkwCcCzID
XL29lOAwmQ8UBr9YOQD3dTA=
=mLoZ
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
