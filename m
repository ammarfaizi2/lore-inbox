Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbTFYPcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTFYPcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:32:32 -0400
Received: from grendel.firewall.com ([66.28.56.41]:44952 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S264687AbTFYPc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:32:28 -0400
Date: Wed, 25 Jun 2003 17:46:27 +0200
From: Marek Habersack <grendel@debian.org>
To: Valdis.Kletnieks@vt.edu
Cc: Steve Lord <lord@sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
Message-ID: <20030625154627.GK1745@thanes.org>
Reply-To: grendel@debian.org
References: <20030625095126.GD1745@thanes.org> <1056545505.1170.19.camel@laptop.americas.sgi.com> <20030625134129.GG1745@thanes.org> <200306251511.h5PFBpdA021017@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AptwxgnoZDC4KQWS"
Content-Disposition: inline
In-Reply-To: <200306251511.h5PFBpdA021017@turing-police.cc.vt.edu>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AptwxgnoZDC4KQWS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2003 at 11:11:51AM -0400, Valdis.Kletnieks@vt.edu scribbled:
[snip]
> > can remove any files created by root whether or not restricted_chown is=
 in
> > effect. That might be quite a nightmare for the admins. Or at the very =
least
> > it's inconsistent with other filesystems.
>=20
> Maybe I'm low on caffeine and therefor misreading it, but isn't this just=
 an
> example of "file rename/remove requires write permission on the *parent*
> dirctory, since that's what's being changed", which often surprises novic=
e (and
> not-so-novice) sysadmins?  See also the reason for the sticky bit on dire=
ctories..
>=20
> In any case, I didn't notice that any behavior (other than the 'chown giv=
eaway')
> was different than other filesystems?
You're right. It must have been me who was low on caffeine. Indeed, the only
problems were the chown giveaway and the quota ownership transfer. Forget
the blurb, sorry

marek

--AptwxgnoZDC4KQWS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++cPTq3909GIf5uoRArF9AJ9Mr2iSILl5G8OhPNHhLtPcPjkcQQCffQ7t
IaWg4bM5vdyXxBl5VHUaze8=
=AMrJ
-----END PGP SIGNATURE-----

--AptwxgnoZDC4KQWS--
