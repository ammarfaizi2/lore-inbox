Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVCAQ0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVCAQ0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 11:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVCAQ0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 11:26:11 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:49886 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261958AbVCAQ0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 11:26:08 -0500
Date: Tue, 1 Mar 2005 17:26:07 +0100
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: James Morris <jmorris@redhat.com>,
       lkml Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, sds@epoch.ncsc.mil,
       Alexander Nyberg <alexn@dsv.su.se>
Subject: Re: [PATCH] SELinux: null dereference in error path
Message-ID: <20050301162605.GI3318@vanheusden.com>
References: <Xine.LNX.4.44.0502282311190.26032-100000@thoron.boston.redhat.com> <F00DE41E-8A09-11D9-858B-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline
In-Reply-To: <F00DE41E-8A09-11D9-858B-000393ACC76E@mac.com>
Organization: www.unixexpert.nl
Read-Receipt-To: <folkert@vanheusden.com>
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Wed Mar  2 16:57:29 CET 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.6+20040907i
From: folkert@vanheusden.com (Folkert van Heusden)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >>The 'bad' label will call function that unconditionally dereferences
> >>the NULL pointer.
> >>Found by the Coverity tool
> >>Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
> >Signed-off-by: James Morris <jmorris@redhat.com>
> Err, isn't it "Acked-by:"??  I thought "Signed-off-by:" was only for=20
> when
> the patch actually went through someone's tree and was forwarded by them
> to somebody else:

Isn't also a good idea to sign your message with gpg or so? That way one
is 100% sure that it *is* that person who is signing-off or acking-by.


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------=3D www.unixsoftware.nl =3D-+
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCJJedMBkOjB8o2K4RAoOAAJ96F23ofaJgAvoouhIx5Xma2aQMvgCglu92
nG3/Io65RJi2MiDjDfQ7kho=
=seqa
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--
