Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVBON7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVBON7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVBON7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:59:53 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:16600 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261731AbVBON4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:56:37 -0500
Date: Tue, 15 Feb 2005 08:56:30 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: John M Flinchbaugh <john@hjsoft.com>, linux-thinkpad@linux-thinkpad.org,
       linux-kernel@vger.kernel.org
Subject: Re: Thinkpad R40 freezes after swsusp resume
Message-ID: <20050215135630.GA20623@butterfly.hjsoft.com>
References: <20050210124636.GA10677@butterfly.hjsoft.com> <20050210183114.GB1577@elf.ucw.cz> <20050211171028.GA20375@butterfly.hjsoft.com> <20050211183241.GD2148@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20050211183241.GD2148@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2005 at 07:32:41PM +0100, Pavel Machek wrote:
> > > Try also acpi=3Doff.

> > i was hoping for a test that's a bit more granular.  might it be
> > possible to disable suspect bits of the acpi code instead of all=20
> > of it?
> > i'm open to applying and testing patches.

> Well, you'd have to write that code, I'd guess.
> And I do not think you can really turn off thermal managment once=20
> you
> enter ACPI mode.

I've gotten 2.6.11-rc4 to freeze after a swsusp, so I'm testing acpi=3Doff
now.

As Murphy's Law would have it, I usually get these lockups at=20
inopportune times when I really don't want to have to punch the power=20
button, like when I'm in a hurry trying to find something or during
long-running network backups.  It also does it when sitting idle, so
this isn't a rule.

I've run most of a backup from an NFS mount to the local drive (for
about 10 minutes), stopped it, swsusp, ran another backup, and it's
looking fine so far.

To be sure that it's not going to freeze, I'd almost have to let it go
for a week, though, because sometimes I had just gotten lucky and not
seen the issue for upto 4 days at a time.

Assuming disabling ACPI causes my trouble to go away, what's my next
step in debugging this issue?  I'd hate to just leave it at "Don't use
ACPI."

Thanks for your time.
--=20
John M Flinchbaugh
john@hjsoft.com

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCEf+OCGPRljI8080RAjnTAJ970jgXBJkVPu36TMQS9V9xOgBoAACgid/5
ThhnwmL/uLeRNE9GrRBPPjA=
=ZaEX
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
