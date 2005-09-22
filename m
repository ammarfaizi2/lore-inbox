Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbVIVRAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVIVRAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 13:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbVIVRAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 13:00:14 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:41671 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030447AbVIVRAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 13:00:12 -0400
Date: Thu, 22 Sep 2005 19:00:09 +0200
From: Harald Welte <laforge@netfilter.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] update Documentation/sparse.txt
Message-ID: <20050922170009.GP26520@sunbeam.de.gnumonks.org>
References: <20050921170539.GA10537@mipter.zuzino.mipt.ru> <20050922132833.GM26520@sunbeam.de.gnumonks.org> <20050922153451.GA7519@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWJEtCrVvH5hpatL"
Content-Disposition: inline
In-Reply-To: <20050922153451.GA7519@mipter.zuzino.mipt.ru>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Thu, Sep 22, 2005 at 07:34:51PM +0400, Alexey
	Dobriyan wrote: > On Thu, Sep 22, 2005 at 03:28:34PM +0200, Harald
	Welte wrote: > > btw, where can I get the latest sparse release? > > >
	> linux-2.6.14-rc2/Documentation/sparse.txt still points to a dead > >
	directory at > >
	http://www.codemonkey.org.uk/projects/git-snapshots/sparse/ > > which
	now seems to be 404. > > > > Are there no snapshots available? Didn't
	anyone convre the bitkeeper > > repository to git or something else?
	I'm a bit puzzled. > > > I use > > rsync -avz --progress --delete \ >
	rsync://rsync.kernel.org/pub/scm/devel/sparse/sparse.git/ \ > .git
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 TW_AV                  BODY: Odd Letter Triples with AV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JWJEtCrVvH5hpatL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2005 at 07:34:51PM +0400, Alexey Dobriyan wrote:
> On Thu, Sep 22, 2005 at 03:28:34PM +0200, Harald Welte wrote:
> > btw, where can I get the latest sparse release?
> >=20
> > linux-2.6.14-rc2/Documentation/sparse.txt still points to a dead
> > directory at
> > http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
> > which now seems to be 404.
> >=20
> > Are there no snapshots available?  Didn't anyone convre the bitkeeper
> > repository to git or something else?  I'm a bit puzzled.
>=20
>=20
> I use
>=20
> rsync -avz --progress --delete \
> 	rsync://rsync.kernel.org/pub/scm/devel/sparse/sparse.git/ \
> 	.git

Thanks.  Please consider this patch for the mainline kernel:


[DOCUMENTATION] sparse no longer uses bk, but git

Signed-off-by: Harald Welte <laforge@netfilter.org>

---
commit 37df3d8b065579042d32a866ae6a00cd57c5812b
tree dd0e013e4744201b2ae13b38e0186477fd2eb47d
parent 0410f33b62b892379270539b189577126ea56ffe
author Harald Welte <laforge@netfilter.org> Do, 22 Sep 2005 18:58:49 +0200
committer Harald Welte <laforge@netfilter.org> Do, 22 Sep 2005 18:58:49 +02=
00

 Documentation/sparse.txt |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/Documentation/sparse.txt b/Documentation/sparse.txt
--- a/Documentation/sparse.txt
+++ b/Documentation/sparse.txt
@@ -51,14 +51,9 @@ or you don't get any checking at all.
 Where to get sparse
 ~~~~~~~~~~~~~~~~~~~
=20
-With BK, you can just get it from
-
-        bk://sparse.bkbits.net/sparse
-
-and DaveJ has tar-balls at
-
-	http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
+With git, you can just get it from
=20
+        rsync://rsync.kernel.org/pub/scm/devel/sparse/sparse.git
=20
 Once you have it, just do
=20
--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--JWJEtCrVvH5hpatL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMuMZXaXGVTD0i/8RAu4yAKCTkohmWuSnKXw0SGLqctuhEhyG9QCfRolW
9ZgwfZpLZkPpQM9fFL1al50=
=alfS
-----END PGP SIGNATURE-----

--JWJEtCrVvH5hpatL--
