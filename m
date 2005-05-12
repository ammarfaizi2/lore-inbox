Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVELCQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVELCQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 22:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVELCQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 22:16:51 -0400
Received: from leviathan.ele.uri.edu ([131.128.51.64]:60304 "EHLO
	leviathan.ele.uri.edu") by vger.kernel.org with ESMTP
	id S261286AbVELCQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 22:16:43 -0400
Subject: Re: several messages
From: Ming Zhang <mingz@ele.uri.edu>
Reply-To: mingz@ele.uri.edu
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       Vladislav Bolkhovitin <vst@vlnb.net>,
       iet-dev <iscsitarget-devel@lists.sourceforge.net>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Dmitry Yusupov <dmitry_yus@yahoo.com>, Sander <sander@humilis.net>,
       David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.60.0505112309430.8122@poirot.grange>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
	 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
	 <1104082357.20050504231722@dns.toxicfilms.tv>
	 <1115305794.3071.5.camel@dhollis-lnx.sunera.com>
	 <20050507150538.GA800@favonius>
	 <Pine.LNX.4.60.0505102352430.9008@poirot.grange> <4281C8A3.20804@vlnb.net>
	 <Pine.LNX.4.60.0505112309430.8122@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZpA+OTE/QB2aoEx65P/m"
Organization: no-dole-available
Date: Wed, 11 May 2005 22:16:16 -0400
Message-Id: <1115864176.5513.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZpA+OTE/QB2aoEx65P/m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

iscsi is scsi over ip.
usb disk is scsi over usb.
so just a different transport.
u are rite. ;)

ming

On Wed, 2005-05-11 at 23:26 +0200, Guennadi Liakhovetski wrote:
> Hello and thanks for the replies
>=20
> On Wed, 11 May 2005, FUJITA Tomonori wrote:
> > The iSCSI protocol simply encapsulates the SCSI protocol into the
> > TCP/IP protocol, and carries packets over IP networks. You can handle
> ...
>=20
> On Wed, 11 May 2005, Vladislav Bolkhovitin wrote:
> > Actually, this is property not of iSCSI target itself, but of any SCSI =
target.
> > So, we implemented it as part of our SCSI target mid-level (SCST,
> > http://scst.sourceforge.net), therefore any target driver working over =
it will
> > automatically benefit from this feature. Unfortunately, currently avail=
able
> > only target drivers for Qlogic 2x00 cards and for poor UNH iSCSI target=
 (that
> > works not too reliable and only with very specific initiators). The pub=
lished
> ...
>=20
> The above confirms basically my understanding apart from one "minor"=20
> confusion - I thought, that parallel to hardware solutions pure software=20
> implementations were possible / being developed, like a driver, that=20
> implements a SCSI LDD API on one side, and forwards packets to an IP=20
> stack, say, over an ethernet card - on the initiator side. And a counter=20
> part on the target side. Similarly to the USB mass-storage and storage=20
> gadget drivers?
>=20
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-ZpA+OTE/QB2aoEx65P/m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCgrxwSYbkL5BnVYoRAp2QAJ9AU6kEvA0GSSFDcScH78c2t62VFgCeKb5f
qSxl1ZZ5ecF+Jpn9jZW73Y4=
=2nN5
-----END PGP SIGNATURE-----

--=-ZpA+OTE/QB2aoEx65P/m--

