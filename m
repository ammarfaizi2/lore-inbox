Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUIDMak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUIDMak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbUIDMak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:30:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52120 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267745AbUIDMai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:30:38 -0400
Subject: Re: New proposed DRM interface design
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dave Airlie <airlied@linux.ie>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409041311020.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
	 <Pine.LNX.4.58.0409040145240.25475@skynet>
	 <20040904102914.B13149@infradead.org>
	 <41398EBD.2040900@tungstengraphics.com>
	 <20040904104834.B13362@infradead.org>
	 <413997A7.9060406@tungstengraphics.com>
	 <20040904112535.A13750@infradead.org>
	 <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com>
	 <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com>
	 <4139B03A.6040706@tungstengraphics.com>
	 <Pine.LNX.4.58.0409041311020.25475@skynet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jmmzGbuiCKmQBad9dTJP"
Organization: Red Hat UK
Message-Id: <1094301014.2801.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 14:30:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jmmzGbuiCKmQBad9dTJP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> If we make a library split that sits inside the kernel, their DRM can
> stop working if someone busts the interface, hence the idea of having the
> core reg/dereg in the kernel, and locking it down, then they can ship a
> complete DRM source tree, and do as they wish as long as they interface
> properly with the core...

or they just ship their own matching core .c file as well....

Lets face it, for the core there are 2 things that are entirely at
conflicts: small interface and core being useful.
I rather go for the useful side myself.


--=-jmmzGbuiCKmQBad9dTJP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBObVWxULwo51rQBIRAlakAJ0W9iORWjMXd37WEtX2N1vlj/ox1wCfWzee
auWnXy5USVKr+pmo7hQJ9mg=
=vkGc
-----END PGP SIGNATURE-----

--=-jmmzGbuiCKmQBad9dTJP--

