Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266004AbUFDVan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbUFDVan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 17:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUFDVan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 17:30:43 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:743 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S266004AbUFDVal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 17:30:41 -0400
Date: Fri, 4 Jun 2004 17:30:37 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Duncan Sands <baldrick@free.fr>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040604213037.GA2881@babylon.d2dc.net>
Mail-Followup-To: Duncan Sands <baldrick@free.fr>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	"David A. Desrosiers" <desrod@gnu-designs.com>,
	linux-usb-devel@lists.sourceforge.net
References: <20040604193911.GA3261@babylon.d2dc.net> <20040604195247.GA12688@kroah.com> <20040604200211.GB3261@babylon.d2dc.net> <200406042240.43490.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <200406042240.43490.baldrick@free.fr>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2004 at 10:40:43PM +0200, Duncan Sands wrote:
> > c4bae310 Call Trace:
> >  [<c0336735>] __down+0x85/0x120
> >  [<c033692f>] __down_failed+0xb/0x14
> >  [<c026af27>] .text.lock.hub+0x69/0x82
> >  [<c0272b7f>] usbdev_ioctl+0x19f/0x710
> >  [<c015a45d>] file_ioctl+0x5d/0x170
> >  [<c015a686>] sys_ioctl+0x116/0x250
> >  [<c0103f8f>] syscall_call+0x7/0xb
>=20
> Does this help?

I'm afraid not.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

I still do not understand why manglement believes that cutting off the
oxygen flow to the brain will INCREASE productivity. The reason they
made that decision is probably because they couldn't think clearly due
to wearing neckties.
  -- Paul Tomko on ASR.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwOn9RFMAi+ZaeAERAgjRAKDPs3gedyjEQK5zi/D79o0XNgY9ZgCgisOR
SP/sRIkkMmUOpAF8AwL2K1k=
=/UEF
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
