Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbUDSKyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 06:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUDSKyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 06:54:10 -0400
Received: from mx2.redhat.com ([66.187.237.31]:43173 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S264344AbUDSKyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 06:54:06 -0400
Subject: Re: /dev/psaux-Interface
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Andrew Morton <akpm@osdl.org>, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       b-gruber@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <xb77jwci86o.fsf@savona.informatik.uni-freiburg.de>
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
	 <Pine.GSO.4.58.0404191124220.21825@stekt37>
	 <20040419015221.07a214b8.akpm@osdl.org>
	 <xb77jwci86o.fsf@savona.informatik.uni-freiburg.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZRmuxCpiG6xInfh7dGNH"
Organization: Red Hat UK
Message-Id: <1082372020.4691.9.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 19 Apr 2004 12:53:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZRmuxCpiG6xInfh7dGNH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> No.   That's not  a  problem  specific with  my  touchscreen.  It's  a
> general  problem  with   the  design  of  the  input   layer.   It  is
> implementing  *policies*  (on how  to  interpret  data  read from  the
> PS2/AUX port), instead of providing  a *mechanism* to access (read and
> write) that port.

well, it's the kernels job to abstract hardware. You don't also expose
raw scsi and ide devices to userspace, you abstract them away and
provide a uniform "block device" interface to userspace.
The input layer tries to do the same wrt HID devices and imo it makes
sense. Why should userspace care if a mouse is attached to the USB port
or via the USB->PS/2 connector thingy to the PS/2 port. Requiring
different configuration for both cases, and potentially even requiring
different userspace applications for each type make it sound like
abstracting this away from userspace does have merit.=20

--=-ZRmuxCpiG6xInfh7dGNH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAg6+0xULwo51rQBIRAuDnAJ4qSOXFsiZ5Jv87zm/iVcyM5+EpBQCfcuCF
3ceueupOF1QpAgS5z8V0fxM=
=90YP
-----END PGP SIGNATURE-----

--=-ZRmuxCpiG6xInfh7dGNH--

