Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVABSms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVABSms (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 13:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVABSms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 13:42:48 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:36229 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261226AbVABSmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 13:42:45 -0500
Date: Sun, 2 Jan 2005 13:42:39 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: Pavel Machek <pavel@ucw.cz>, John M Flinchbaugh <john@hjsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050102184239.GA21322@butterfly.hjsoft.com>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 01, 2005 at 09:57:53PM -0800, Barry K. Nathan wrote:
> > e100 does not help, fault is not in e100]. Are you running with APIC
> > enabled? Try noapic. Try acpi=3Doff.
> Reloading doesn't help, with either e100 or 8139too. I forgot to=20
> mention
> that in my other e-mail in this thread. (As I previously mentioned,=20
> on
> my system with 8139too, noapic makes matters worse, and the problem=20
> goes
> away if I use *either* pci=3Drouteirq or acpi=3Doff. I haven't tried=20
> using
> both.)

pci=3Drouteirq worked for me to get my e100 working again after resume.

so what's that mean?  what's the trade-off for using this option?

thanks for the guidance.
--=20
John M Flinchbaugh
john@hjsoft.com

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2ECfCGPRljI8080RArnoAJ4pDtLITwqFRpJxQH8am6wC+xcMhQCfdp5T
L6FYfMWIWnlhLrF+Bcf73Zg=
=yaA8
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
