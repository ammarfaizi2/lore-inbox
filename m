Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268215AbUIPRco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268215AbUIPRco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268334AbUIPRcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:32:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43497 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268215AbUIPRai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:30:38 -0400
Date: Thu, 16 Sep 2004 19:30:22 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Message-ID: <20040916173022.GA6793@devserv.devel.redhat.com>
References: <20040916024020.0c88586d.akpm@osdl.org> <200409161345.56131.norberto+linux-kernel@bensa.ath.cx> <1095354962.2698.22.camel@laptop.fenrus.com> <200409161428.10717.norberto+linux-kernel@bensa.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <200409161428.10717.norberto+linux-kernel@bensa.ath.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 16, 2004 at 02:28:10PM -0300, Norberto Bensa wrote:
> Arjan van de Ven wrote:
> > On Thu, 2004-09-16 at 18:45, Norberto Bensa wrote:
> > > Andrew Morton wrote:
> > > > +tune-vmalloc-size.patch
> > >
> > > This one of course breaks nvidia's binary driver; so nvidia users should
> > > do a "patch -Rp1" to revert it.
> >
> > eh why how ?? what evil stuff is nvidia doing this time ?
> 
> On modprobe it says: "__VMALLOC_RESERVE undefined symbol". I'm almost sure is 
> an #include thing, but since I know near to nothing about the kernel 
> internals, I prefer to revert the patch.

I would consider it REALLY weird for a module to use detailed vmalloc
knowledge like this. Does anyone know what they are doing?????

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBSc2uxULwo51rQBIRAhpHAJ4/IAFZAKv2bg1+wmcAHyupMUuqPQCfUc9r
WP+ez5JgOGHzqcgemlsiIe0=
=n3aZ
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
