Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUDTSx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUDTSx6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 14:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263670AbUDTSx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 14:53:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7602 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263818AbUDTSxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 14:53:55 -0400
Subject: Re: slab-alignment-rework.patch in -mc
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrew Morton <akpm@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, andrea@suse.de, agruen@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040420112556.400ea49e.akpm@osdl.org>
References: <1082383751.6746.33.camel@f235.suse.de>
	 <20040419162533.GR29954@dualathlon.random>
	 <4084017C.5080706@colorfullife.com> <20040420002423.469cca01.akpm@osdl.org>
	 <20040420144937.GG29954@dualathlon.random>
	 <40855C97.1090006@colorfullife.com> <20040420112556.400ea49e.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-n9vKEhgSTUUrUN1G+JZg"
Organization: Red Hat UK
Message-Id: <1082487225.9708.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Apr 2004 20:53:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n9vKEhgSTUUrUN1G+JZg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> But why would you choose to make the "SLAB_HWCACHE_ALIGN clear" case use
> sizeof(void*) rather than sizeof(int)?
so that if you kmalloc a struct the pointers in it don't cause unaligned
exceptions on 64 bit ;)

--=-n9vKEhgSTUUrUN1G+JZg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAhXG4xULwo51rQBIRAieuAJ9A+YJDCQTLEmnxsgONF/u6zxX7xwCeOSYw
shIPfngg3EIdsYdYC/WkJ5I=
=sOlb
-----END PGP SIGNATURE-----

--=-n9vKEhgSTUUrUN1G+JZg--

