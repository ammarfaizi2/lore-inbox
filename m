Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTEIOzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 10:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTEIOzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 10:55:36 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:45808 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263271AbTEIOzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 10:55:35 -0400
Subject: Re: Undo aic7xxx changes
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Willy Tarreau <willy@w.ods.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20030509145621.GA17581@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	 <2804790000.1052441142@aslan.scsiguy.com>
	 <20030509120648.1e0af0c8.skraw@ithnet.com>
	 <20030509120659.GA15754@alpha.home.local>
	 <20030509150207.3ff9cd64.skraw@ithnet.com>
	 <20030509132757.GA16649@alpha.home.local>
	 <20030509154637.5cf14c8d.skraw@ithnet.com>
	 <20030509145621.GA17581@alpha.home.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kxQQ0/znm7iXJOBm499C"
Organization: Red Hat, Inc.
Message-Id: <1052492883.1529.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 09 May 2003 17:08:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kxQQ0/znm7iXJOBm499C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> ull on 32 bits archs, because addr is
> a bus_addr_t which is in turn dma_addr_t which itself is u32. So unless I=
 don't
> find the trick this would mean that this code should never be executed. P=
erhaps

dma_addr_t is either u32 or u64 on x86


--=-kxQQ0/znm7iXJOBm499C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+u8RTxULwo51rQBIRAqkgAJ4/BA6yruh05oHbQV15nRTVJ/pB6gCfV+AP
JBlXLgDDQh+vy4K4WU+JVP4=
=IsYH
-----END PGP SIGNATURE-----

--=-kxQQ0/znm7iXJOBm499C--
