Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424761AbWKQFZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424761AbWKQFZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 00:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162363AbWKQFZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 00:25:09 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:38540 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1162362AbWKQFZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 00:25:07 -0500
Date: Fri, 17 Nov 2006 00:27:55 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Christian Hoffmann <chrmhoffmann@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Message-ID: <20061117052755.GA23831@shaftnet.org>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	Christian Hoffmann <chrmhoffmann@gmail.com>,
	Andrew Morton <akpm@osdl.org>,
	Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611151109.06956.rjw@sisk.pl> <200611162317.30880.chrmhoffmann@gmail.com> <200611162344.41622.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <200611162344.41622.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Fri, 17 Nov 2006 00:27:57 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2006 at 11:44:40PM +0100, Rafael J. Wysocki wrote:
> I think the call to radeon_restore_pci_cfg(rinfo) causes the problem to h=
appen.

radeonfb is still using its own code for saving and restoring PCI=20
registers; I'm in the process of fixing it up to use proper PCI
subsystem calls.  That will hopefully work better.  =20

It's possible there's a good reason (other than "nobody's ported it over=20
yet") that the radeonfb driver is doing it manually, but I don't know=20
why that would be the case. =20

 - Solomon
--=20
Solomon Peachy        		       pizza at shaftnet dot org	=20
Melbourne, FL                          ^^ (mail/jabber/gtalk) ^^
Quidquid latine dictum sit, altum viditur.          ICQ: 1318344


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFFXUhbPuLgii2759ARAoM7AJ92AH2t3kpROkjO2Pwtx7sWt5U1xQCgvUx1
T00pEpjZeRpDE3iOB7ZgqWQ=
=a402
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
