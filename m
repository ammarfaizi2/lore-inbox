Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVBKRLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVBKRLA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVBKRLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:11:00 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:49338 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262277AbVBKRKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:10:42 -0500
Date: Fri, 11 Feb 2005 12:10:28 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: John M Flinchbaugh <john@hjsoft.com>, linux-thinkpad@linux-thinkpad.org,
       linux-kernel@vger.kernel.org
Subject: Re: Thinkpad R40 freezes after swsusp resume
Message-ID: <20050211171028.GA20375@butterfly.hjsoft.com>
References: <20050210124636.GA10677@butterfly.hjsoft.com> <20050210183114.GB1577@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20050210183114.GB1577@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 10, 2005 at 07:31:14PM +0100, Pavel Machek wrote:
> Try also acpi=3Doff.

i was hoping for a test that's a bit more granular.  might it be
possible to disable suspect bits of the acpi code instead of all of it?
i'm open to applying and testing patches.

disabling all of acpi for a week or 2 (sometimes my notebook will go=20
4 days of daily suspending and resuming without trouble, now) doesn't=20
sound like fun.  i like acpi events and information.

my latest test is to trim my suspend script.  from earlier versions of
the swsusp code, i had been disabling laptop-mode, turning swappiness up
to 100%, saving the hwclock, etc.  having taken all that out, i find it
unnecessary anymore.

--=20
John M Flinchbaugh
john@hjsoft.com

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCDOcECGPRljI8080RApTlAJ9vUvZkjuilFVjod64UNh1/pN+nVgCfavGm
q15575FPKwPtHRy8DZ3RSpc=
=K5lD
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
