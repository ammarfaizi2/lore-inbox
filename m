Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUFEU4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUFEU4E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 16:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUFEU4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 16:56:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261932AbUFEU4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 16:56:01 -0400
Date: Sat, 5 Jun 2004 22:55:47 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
Message-ID: <20040605205547.GD20716@devserv.devel.redhat.com>
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 05, 2004 at 01:45:33PM -0700, Linus Torvalds wrote:
> so I wonder if either the Fedora libc always adds that CLONE_THREAD thing
> to the clone() calls, or whether the FC2 kernel is buggy.

... or glibc internally caches the getpid() result and doesn't notice the
app calls clone() internally... strace seems to show 1 getpid() call total
not 2.


--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAwjNTxULwo51rQBIRAngBAJ4kXtb3/Dm/R3Q1zarhJyeEtlECFgCfQ2Hr
zqf4ZAq3UG3kfF2atlzLD+4=
=uFeC
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
