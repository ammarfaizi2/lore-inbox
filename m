Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267238AbUIDKhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267238AbUIDKhX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUIDKhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:37:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53730 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267238AbUIDKhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:37:17 -0400
Date: Sat, 4 Sep 2004 12:37:11 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
Message-ID: <20040904103711.GD5313@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0409041053450.25475@skynet> <1094292878.2801.7.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409041126500.25475@skynet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409041126500.25475@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 04, 2004 at 11:30:40AM +0100, Dave Airlie wrote:
> > it looks you can nuke most of those.
> > > -#if __REALLY_HAVE_AGP
> > > +#if __OS_HAS_AGP
> > >  	drm_agp_head_t    *agp;	/**< AGP data */
> > >  #endif
> >
> > for example does this extra pointer really hurt in the *really* unlikely
> > case you don't have AGP ?
> 
> actually it's not just the pointer it is the structure drm_agp_head_t I
> think it needs some agp includes to work ..

... or a dummy drm_agp_head_t typedef.


--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBOZrWxULwo51rQBIRAmKpAJ0dZoewG34YX3GizmjPhjt35SsMzQCff5GN
QvXbpEu4ButPWFc5HoojcUw=
=rt6s
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
