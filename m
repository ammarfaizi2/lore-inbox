Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUCZEfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 23:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUCZEfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 23:35:40 -0500
Received: from 66-194-152-191.gen.twtelecom.net ([66.194.152.191]:45708 "EHLO
	pico.surpasshosting.com") by vger.kernel.org with ESMTP
	id S263228AbUCZEfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 23:35:37 -0500
Date: Thu, 25 Mar 2004 22:34:47 -0600
From: Chris Cheney <ccheney@cheney.cx>
To: Len Brown <len.brown@intel.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
       acpi-devel-request@lists.sourceforge.net, patches@x86-64.org,
       Andi Kleen <ak@suse.de>, pavel@ucw.cz
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-ID: <20040326043447.GD9248@cheney.cx>
References: <20040325033434.GB8139@atomide.com> <20040326030458.GZ9248@cheney.cx> <20040326033536.GA8057@atomide.com> <1080274911.748.130.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G/vVCphCGw+yuveY"
Content-Disposition: inline
In-Reply-To: <1080274911.748.130.camel@dhcppc4>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pico.surpasshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cheney.cx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G/vVCphCGw+yuveY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2004 at 11:21:51PM -0500, Len Brown wrote:
> On Thu, 2004-03-25 at 22:35, Tony Lindgren wrote:
> > * Chris Cheney <ccheney@cheney.cx> [040325 19:06]:
> > > On Wed, Mar 24, 2004 at 07:34:34PM -0800, Tony Lindgren wrote:
> > >=20
> > > BTW - Does this also solve the problem with needing USB to be compiled
> > > directly into the kernel in 64bit mode?
> >=20
> > OK, tried it and it does not help there. Also loding ACPI processor and
> > thermal zone compiled in hangs the machine, but loading them as modules
> > work.
>=20
> where does it hang when processor and thermal are compiled-in?

You had mentioned before there is a way to decompile SSDT with 3rd party
(non iasl.exe) asl tools, do you happen to know where to get them? Also
does the usual dsdt override patch (acpi.sf.net) allow you to override
the ssdt or does it only work for the dsdt?

> >  The power button still turns off the machine immedieately too with
> > ACPI on.
>=20
> Then ACPI is not on.  what does dmesg show?

This seems similiar to what I saw with my machine and mentioned in
#2090, when I hit the power button just right, for lack of a better
description, it would dump acpi_ev_dispatch errors, otherwise it
would immediately shut off. It certainly didn't take the usual ~ 4s hold
down time to shut off.

Chris

--G/vVCphCGw+yuveY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAY7Ln0QZas444SvIRAtzhAJ9SZqpR+cEw/DvDCXKWcsDJVYRiKQCgn1OB
b/ouNe10RzNKHda/vW3uh+E=
=BksM
-----END PGP SIGNATURE-----

--G/vVCphCGw+yuveY--
