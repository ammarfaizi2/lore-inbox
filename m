Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVCHC7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVCHC7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVCHC4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:56:36 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:7818 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261285AbVCHCwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:52:15 -0500
Date: Tue, 8 Mar 2005 03:52:15 +0100
From: Michal Januszewski <spock@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, mls@suse.de
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050308025215.GA27745@spock.one.pl>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com> <20050219232519.GC1372@elf.ucw.cz> <20050220132600.GA19700@spock.one.pl> <20050227165420.GD1441@elf.ucw.cz> <1109532700.15362.42.camel@laptopd505.fenrus.org> <20050227195206.GA2202@spock.one.pl> <20050227210333.GA18820@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20050227210333.GA18820@kroah.com>
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 27, 2005 at 01:03:33PM -0800, Greg KH wrote:

> Care to create a patch for the silent mode now?  That should be simple
> enough to get into the kernel, and will be a good place to build off of
> for the rest of the things people want (verbose mode, etc.)

I've just sent the whole thing split up into seven parts. After working
on both fbsplash and splashutils for the last few days, I came to the
conclusion that the initial silent mode patch wouldn't make much sense
(it would create a short fbsplash.c file with a single call to
call_usermodehelper()) and the whole splash interface thing would
completely pointless.

I tried to move as much as possible into userspace. If anyone can find=20
away to move more code to the userspace, please let me know -- I'd be=20
glad to make fbsplash even lighter :)

Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCLRNfaQ0HSaOUe+YRAjLCAKCxSKUrJdZGQ+2O8MC4bbdIRJct8ACfXRha
uOvAXGrfhaSmClCf5MbtMaY=
=ztxR
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
