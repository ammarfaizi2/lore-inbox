Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWC1Rbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWC1Rbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWC1Rbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:31:48 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:2533 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751189AbWC1Rbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:31:47 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Issues with uli526x networking module
Date: Tue, 28 Mar 2006 19:30:53 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
References: <200601260900.57951.prakash@punnoor.de> <200601262110.48090.ncunningham@cyclades.com>
In-Reply-To: <200601262110.48090.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4669399.B41izerBRW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603281930.53859.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4669399.B41izerBRW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag Januar 26 2006 12:10 schrieb Nigel Cunningham:
> Hi.
>
> On Thursday 26 January 2006 18:00, Prakash Punnoor wrote:
> > Hi,
> >
> > I have some problems with the uli526x driver. (I cc'ed the tulip
> > maintainer, as the driver is found in this category.)
> >
> > - It doesn't detect link when cable is plugged in, if module/driver is
> > loaded with no cable attached. I have to rmmod the module, plug in cabl=
e,
> > insmod the module and then set up the interface to get it running. That=
's
> > the only reason I compiled this driver as a module...(BTW, it is not
> > AMD64 related, as I experienced this also in x86.)
> >
> > - dhcpcd doesn't work. dhclient does though (but it is slow, I can't fi=
nd
> > the correct parameters to speed it up). The former gets no response from
> > the dhcp server. I don't think it is a problem with the dhcp server, as
> > dhcpcd works from a notebook with some dlink pcmcia 10mbit interface.
> >
> >
> > Beside above, it seems to work fine, though.
>
> I have one too, and have done some work toward implementing power
> management support (working, but needs further work). I've noticed the li=
nk
> issue and will see if I can address it too. Regarding dhcpcd, I haven't
> used it, but will see if I can test before sending the patches to Jeff and
> to Peer Chen.

Hi, I am just wondering whether you found out what the issue is with the li=
nk=20
problem. If you have some patch ready (even if it is hackish) I would be=20
happy to use it.

Anyways, I know you are busy with swsusp2. ;-)

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart4669399.B41izerBRW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEKXLNxU2n/+9+t5gRAnySAJ4/Ux1QqzVrGG5Q+P/+I4XDQtB+mACeOW2H
8ph0sh1YCiEULq/5OysgZhQ=
=dpA5
-----END PGP SIGNATURE-----

--nextPart4669399.B41izerBRW--
