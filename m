Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261474AbTCaJBf>; Mon, 31 Mar 2003 04:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261479AbTCaJBf>; Mon, 31 Mar 2003 04:01:35 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:15080 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S261474AbTCaJBe>; Mon, 31 Mar 2003 04:01:34 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: NFS/ReiserFS problems 2.5.64-mbj1
Date: Mon, 31 Mar 2003 11:12:21 +0200
User-Agent: KMail/1.5
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
       Bill Huey <billh@gnuppy.monkey.org>
References: <20030327092207.GA1248@gnuppy.monkey.org> <200303281157.51743.schlicht@uni-mannheim.de> <16005.11608.478233.424677@notabene.cse.unsw.edu.au>
In-Reply-To: <16005.11608.478233.424677@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_BaAi+z7IuLjj/3F";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303311112.33437.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_BaAi+z7IuLjj/3F
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Marc 29, Neil Brown wrote:
> One possibility is that you are using the new nfs-utils 1.0.3, but you
> reported the bug before I announced it (though it was in CVS and on
> kernel.org by then so maybe...)!
> The new code uses a different path to export filesystems which didn't
> include the setting of find_exported_dentry.
> The following patch should fix that.

Yes, it did!
With that patch NFS works perfectly via TCP (I've still very big problems w=
ith=20
UDP over a 10MBit half-duplex connection. :-( But that's an other problem..=
=2E=20
) So this patch has to land in linus' tree...

Regards
   Thomas Schlichter
--Boundary-02=_BaAi+z7IuLjj/3F
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+iAaAYAiN+WRIZzQRAgchAKCIRH2IN0hWm6rQU3vcpw9zEeA41ACfWftb
hXbCnL16Pwebjl5i0aSzCZ8=
=p57P
-----END PGP SIGNATURE-----

--Boundary-02=_BaAi+z7IuLjj/3F--

