Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUCEVlA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUCEVlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:41:00 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15261 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261262AbUCEVk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:40:58 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Fri, 5 Mar 2004 16:40:54 -0500
To: Jason Munro <jason@stdbev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI battery info failure after some period of time, 2.6.3-x and up
Message-ID: <20040305214054.GA983@butterfly.hjsoft.com>
References: <4047756D.2050402@blue-labs.org> <200403051520.40341.sgy-lkml@amc.com.au> <4048015D.6070308@blue-labs.org> <200403051543.04300.sgy-lkml@amc.com.au> <Pine.LNX.4.58.0403051259480.387@boston.corp.fedex.com> <950c9d8cf6fbb225c867dff9a4284d0c@stdbev.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <950c9d8cf6fbb225c867dff9a4284d0c@stdbev.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > have you tried applying patch from ...
> > ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release
> > /2.6.4/
> > acpi-20040220-2.6.4.diff.bz2

this patch did not help on my dell inspiron 3800.  the battery
status worked with 2.6.0, but it's been broken in the past
couple versions.  same as others were seeing:
ACPI-0279: *** Error: Looking up [BST0] in namespace, AE_ALREADY_EXISTS
ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._BST]
(Node d7fc7ba0), AE_ALREADY_EXISTS

i'm trying 2.6.4-rc2 with this acpi patch.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFASPPmCGPRljI8080RAj52AJ4mU9JHAbrhcOnnL8RQCw2jAaV4UgCgks/d
20E0Da5LofpY0J9ngiub2Y4=
=0ImI
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
