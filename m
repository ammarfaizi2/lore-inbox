Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUHCVlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUHCVlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUHCVku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:40:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52161 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266888AbUHCVj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:39:56 -0400
Date: Tue, 3 Aug 2004 23:38:57 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803213856.GB10978@devserv.devel.redhat.com>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com> <20040803210737.GI2241@dualathlon.random> <20040803211339.GB26620@devserv.devel.redhat.com> <20040803213634.GK2241@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <20040803213634.GK2241@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 03, 2004 at 11:36:34PM +0200, Andrea Arcangeli wrote:
> On Tue, Aug 03, 2004 at 11:13:39PM +0200, Arjan van de Ven wrote:
> > The user that mlock'd gets to pay for it, and gets his credits back at
> > munlock. Chown doesn't really matter in that regard..... The thing that does
> 
> what? he cannot get credits when it munlock if this is hugetlbfs. If it
> does you're again into the insecure DoS scenario.

not if you keep track of who locked in the first place and give the credit
back to *that* user (struct).

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBEAXwxULwo51rQBIRAgyXAJ9Y9S/91oz3u8wptyR9tt2CLcjIGACfZvor
j5G7FMqlk8nnv5H6n1GgCeI=
=4dcr
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
