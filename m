Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTJPNvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 09:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTJPNvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 09:51:55 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:39619 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S262947AbTJPNvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 09:51:53 -0400
Date: Thu, 16 Oct 2003 15:51:34 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Javier Achirica <achirica@telefonica.net>
Cc: Celso =?ISO-8859-1?Q?Gonz=E1lez?= <celso@mitago.net>,
       Marc Giger <gigerstyle@gmx.ch>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: airo regression with Linux 2.4.23-pre2
Message-Id: <20031016155134.612b61d5.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.SOL.4.30.0310152323320.21600-100000@tudela.mad.ttd.net>
References: <20031015194754.GA14859@viac3>
	<Pine.SOL.4.30.0310152323320.21600-100000@tudela.mad.ttd.net>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__16_Oct_2003_15_51_34_+0200_7tk53DhPGgdCWVTC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__16_Oct_2003_15_51_34_+0200_7tk53DhPGgdCWVTC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2003 23:27:35 +0200 (MEST) Javier Achirica (JA) wrote:

Hi,

JA> Anyway, I've been discussing this issue with Celso and looks like the line
JA> he mentions make his configuration fail. I added it because in other cases
JA> it makes it work. Anyway, please test the driver removing that line and if
JA> it fixes the problem I'll just try to figure out the exact cases when it's
JA> neede (Cisco hasn't been very helpful about it)..

JA> > Try removing this line on airo.c
JA> > Line 2948
JA> > ai->config._reserved1a[0] = 2 /* ??? */

Removing the line mentioned above fixes my problems as well. Thanks Celso.

-Udo.

--Signature=_Thu__16_Oct_2003_15_51_34_+0200_7tk53DhPGgdCWVTC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE/jqJpnhRzXSM7nSkRAsm4AJ4j8fcNWtDezbtIbUmkNuNJhH975wCfSzr1
r0ZUa/B94eBs1Pzhwvu97y8=
=hRJf
-----END PGP SIGNATURE-----

--Signature=_Thu__16_Oct_2003_15_51_34_+0200_7tk53DhPGgdCWVTC--
