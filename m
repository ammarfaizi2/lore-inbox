Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVAAW0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVAAW0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 17:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVAAW0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 17:26:12 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:52379 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261192AbVAAW0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 17:26:08 -0500
Date: Sat, 1 Jan 2005 17:17:22 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050101221722.GA28045@butterfly.hjsoft.com>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20050101172344.GA1355@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 01, 2005 at 06:23:44PM +0100, Pavel Machek wrote:
> e100 seems to have some suspend/resume support [but if even reloading
> e100 does not help, fault is not in e100]. Are you running with APIC
> enabled? Try noapic. Try acpi=3Doff.

it had been fine in 2.6.9.  i think i had switched to using apic back
with 2.6.9 (to facilitate nmi_watchdog, maybe).

i'll try these options.  ultimately, though, i'm going to need acpi. :)

thanks.
--=20
John M Flinchbaugh
john@hjsoft.com

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB1yFyCGPRljI8080RAqOGAJ4vxlVrtxLdOt/A4XPAPLLXSf3/wQCfXYtH
2bPGRmP9mtgeM89Fa/kSCDg=
=nGOT
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
