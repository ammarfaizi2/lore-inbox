Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTJGEbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 00:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTJGEbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 00:31:46 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:19341 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S261793AbTJGEbk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 00:31:40 -0400
From: Malte =?iso-8859-1?q?Schr=F6der?= <MalteSch@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 3c59x on 2.6.0-test3->test6 slow
Date: Tue, 7 Oct 2003 06:31:30 +0200
User-Agent: KMail/1.5.9
References: <200310061529.56959.domen@coderock.org> <200310070144.47822.domen@coderock.org> <Pine.LNX.4.53.0310062016340.19396@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0310062016340.19396@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_iGkg/ppK1jpoxFZ";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310070631.30972.MalteSch@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_iGkg/ppK1jpoxFZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

mii-tool does not work for me either. I thought mine was outdated or someth=
ing=20
like that ;)
Oh, kernel is -test6-mm4.

# mii-tool -V
mii-tool.c 1.9 2000/04/28 00:56:08 (David Hinds)

# mii-tool eth0
SIOCGMIIPHY on 'eth0' failed: Operation not supported

On Tuesday 07 October 2003 02:18, Zwane Mwaikambo wrote:
> On Tue, 7 Oct 2003, Domen Puncer wrote:
> > On Tuesday 07 of October 2003 00:43, Zwane Mwaikambo wrote:
> > > On Tue, 7 Oct 2003, Domen Puncer wrote:
> > > > > Ok, could you send your .config too, i use the 3c59x driver and
> > > > > haven't noticed this in 2.6.0-test5-mm4. My card is;
> > > >
> > > > .config at the end of mail
> > >
> > > Sorry i forgot to ask for a dmesg too (from a kernel exhibiting the
> > > problem)
> >
> > 0000:00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xd400. Vers LK1.1.19
> > eth0: no IPv6 routers present
> > eth0: Setting full-duplex based on MII #24 link partner capability of
> > 0141.
>
> What is your link peer?
>
> > Might be relevant... the last line is lagged a couple of seconds, and
> > network works fine before i see that line in dmesg.
>
> I'm also curious as to why mii-tool doesn't work, can you attach an strace
> mii-tool eth0?
>
> -
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


--Boundary-02=_iGkg/ppK1jpoxFZ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/gkGi4q3E2oMjYtURAoB3AKCC+t932l4HNRS8uYSE95Qzp5sKrwCfSBL+
znh1QHLVggvaMvT3wbwGurU=
=bqGB
-----END PGP SIGNATURE-----

--Boundary-02=_iGkg/ppK1jpoxFZ--
