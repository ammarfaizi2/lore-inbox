Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263967AbTI2Rq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTI2Rom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:44:42 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:63130 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S263967AbTI2RmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:42:15 -0400
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] [2.6.0-test6] Stale NFS file handle
Date: Mon, 29 Sep 2003 19:42:04 +0200
User-Agent: KMail/1.5.3
References: <200309282031.54043.MalteSch@gmx.de> <20030928184841.GL532@neon>
In-Reply-To: <20030928184841.GL532@neon>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_v7Ge/lqrMlaQ1w0";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309291942.07724.MalteSch@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_v7Ge/lqrMlaQ1w0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Sunday 28 September 2003 20:48, Axel Siebenwirth wrote:
> Hi Malte!
>
> On Sun, 28 Sep 2003, Malte Schr?der wrote:
> > Hi,
> > since 2.6.0-test6 I get "Stale NFS file handle" when transferring huge
> > amounts of data from a nfs-server which is running on -test6.
> > The client also runs -test6. Transfers from a server running kernel
> > 2.4.22 work flawless.
> >
> > I use the nfs-kernel-server 1.0.6 on Debian/sid.
>
> Are you using mount options when mounting the NFS volume?
> I had this problem when I used rsize=3D8192 and wsize=3D8192 as nfs mount
Does not make a difference .. but there seems to be something wrong in the=
=20
code as far as I can interpret what I read on this list ...
=46or now I'm using the user-space-deamon .. work's fine :)

> options. Just left them out and everything was fine again.
>
> Axel
>
>
>
> _________________________________________________________________________=
__
>_ Axel Siebenwirth				      phone +49 3641 776807 |
> Am Birnstiel 3			 		  axel at pearbough dot net |
> 07745 Jena								    |
> Germany________________________________________________http://pearbough.n=
et
> |
>
> For my birthday I got a humidifier and a de-humidifier...  I put them in
> the same room and let them fight it out.
>                 -- Stephen Wright
> _________________________________________________________________________=
__
>_ -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
=2D--------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
=2D--------------------------------------


--Boundary-02=_v7Ge/lqrMlaQ1w0
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/eG7v4q3E2oMjYtURAnj9AJ49cehsXXa6gYZkMAeoMhpJgEPAGgCg6XBK
ov0uFuD96t1UaT/2bALDxuo=
=2bwR
-----END PGP SIGNATURE-----

--Boundary-02=_v7Ge/lqrMlaQ1w0--

