Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264863AbUFHG0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264863AbUFHG0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 02:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUFHG0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 02:26:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9175 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264863AbUFHG0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 02:26:36 -0400
Subject: Re: 4k stacks in 2.6
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Timothy Miller <miller@techsource.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40C4B09B.406@techsource.com>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com>
	 <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu>
	 <20040526125014.GE12142@wohnheim.fh-wedel.de>
	 <20040526125300.GA18028@devserv.devel.redhat.com>
	 <20040526130047.GF12142@wohnheim.fh-wedel.de> <40C4B09B.406@techsource.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TxGDzqrfr7ZCyc2nHrXj"
Organization: Red Hat UK
Message-Id: <1086675984.2736.20.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Jun 2004 08:26:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TxGDzqrfr7ZCyc2nHrXj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> That gave me an idea.  Sometimes in chip design, we 'overconstrain' the=20
> logic synthesizer, because static timing analyzers often produce=20
> inaccurate results.  Anyhow, what if we were to go to 4K stacks but in=20
> static code analysis, flag anything which uses more than 2K or even 1K?

the patch I sent to akpm went to 400 bytes actually, but yeah, even that
already is debatable.

--=-TxGDzqrfr7ZCyc2nHrXj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAxVwQxULwo51rQBIRAo9dAJ9dE6Wo4crjB8jq1YHGrRYlHJipLQCfRy7J
FHGFSK9zVoT36lwwFUmY3k8=
=gl3/
-----END PGP SIGNATURE-----

--=-TxGDzqrfr7ZCyc2nHrXj--

