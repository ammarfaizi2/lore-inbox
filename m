Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267432AbUGNQLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267432AbUGNQLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 12:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267441AbUGNQK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 12:10:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267432AbUGNQJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 12:09:01 -0400
Date: Wed, 14 Jul 2004 18:08:25 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Michael Buesch <mbuesch@freenet.de>
Cc: William Stearns <wstearns@pobox.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Q] don't allow tmpfs to page out
Message-ID: <20040714160825.GA23155@devserv.devel.redhat.com>
References: <200407141654.31817.mbuesch@freenet.de> <200407141803.21388.mbuesch@freenet.de> <20040714160421.GD22641@devserv.devel.redhat.com> <200407141807.11086.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <200407141807.11086.mbuesch@freenet.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 14, 2004 at 06:07:08PM +0200, Michael Buesch wrote:
> Quoting Arjan van de Ven <arjanv@redhat.com>:
> > On Wed, Jul 14, 2004 at 06:03:18PM +0200, Michael Buesch wrote:
> > > >
> > > > which is why there is ramfs .. :)
> > >
> > > In 2.4, too? Can't find it.
> > > What's the CONFIG_* of ramfs?
> >
> > CONFIG_RAMFS
> 
> Ok, that's the thing /dev/ram* is about, isn't it?

nope

> I already have a /dev/ram mounted somewhere, but it's
> not dynamic in size. What am I missing. I'm kind of
> confused now. :)

yes you are;

just do 
mount -t ramfs none /mnt/point


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA9Vp4xULwo51rQBIRAoJEAJ9p2xHGYTJ2sPKoIJwPlRSLgd6gBACfZ0MC
5KfLA9wAvxgUq4ePrUJHbO4=
=Hm7j
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
