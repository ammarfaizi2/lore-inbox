Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266130AbUFUGrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUFUGrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 02:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266131AbUFUGrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 02:47:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55454 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266130AbUFUGrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 02:47:41 -0400
Date: Mon, 21 Jun 2004 08:47:01 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Hannu Savolainen <hannu@opensound.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Martin Schlemmer <azarah@nosferatu.za.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, Dev Mazumdar <dev@opensound.com>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040621064700.GA19511@devserv.devel.redhat.com>
References: <20040620211905.GA10189@mars.ravnborg.org> <1087767034.14794.42.camel@nosferatu.lan> <20040620220319.GA10407@mars.ravnborg.org> <Pine.LNX.4.58.0406210242300.16975@zeus.compusonic.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406210242300.16975@zeus.compusonic.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 21, 2004 at 03:29:24AM +0300, Hannu Savolainen wrote:
> Does something like the following sound good?
> 
> sh /lib/modules/`uname -r`/build/make_module $MYSUBDIR CC=$CC


no you shold not override the compiler; the makefiles should do that instead
automatically

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA1oRkxULwo51rQBIRAsA4AKCVh+sp5hTHdJrlRTptlkTD/aagNQCfcQuU
bmFGkdyYD4oYgLAGVHRvmlU=
=3iWz
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
