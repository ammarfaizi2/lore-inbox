Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbTC3TtN>; Sun, 30 Mar 2003 14:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbTC3TtN>; Sun, 30 Mar 2003 14:49:13 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:26063 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S261521AbTC3TtL>; Sun, 30 Mar 2003 14:49:11 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: NFS/ReiserFS problems 2.5.64-mbj1
Date: Sun, 30 Mar 2003 21:52:06 +0200
User-Agent: KMail/1.5
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
       Bill Huey <billh@gnuppy.monkey.org>
References: <20030327092207.GA1248@gnuppy.monkey.org> <200303281157.51743.schlicht@uni-mannheim.de> <16005.11608.478233.424677@notabene.cse.unsw.edu.au>
In-Reply-To: <16005.11608.478233.424677@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_or0h+K05R9s3aT7";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303302152.08197.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_or0h+K05R9s3aT7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On March 29, Neil Brown wrote:
> One possibility is that you are using the new nfs-utils 1.0.3, but you
> reported the bug before I announced it (though it was in CVS and on
> kernel.org by then so maybe...)!

You are right, I am using the nfs-utils 1.0.3 as I downloaded them as soon =
as=20
I saw them on kernel.org... ;-)

> The new code uses a different path to export filesystems which didn't
> include the setting of find_exported_dentry.
> The following patch should fix that.

Thank you!
I'll try it tonight and write you my results...

> If you aren't using 1.0.3, then I am at a loss.  A filesystem can only
> be exported via call to exp_export, and that does set
>   sb->s_export_op->find_exported_dentry
>=20
> NeilBrown

Thomas Schlichter
--Boundary-02=_or0h+K05R9s3aT7
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+h0roYAiN+WRIZzQRAk3BAKCDq3V5SCa6n3e+e64eT6i9+qAlpQCfcdia
C1nJlAZeSkwJdIuyOMDhKqU=
=JGL2
-----END PGP SIGNATURE-----

--Boundary-02=_or0h+K05R9s3aT7--

