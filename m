Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVBJMqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVBJMqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 07:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVBJMqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 07:46:53 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:20104 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262110AbVBJMqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 07:46:50 -0500
Date: Thu, 10 Feb 2005 07:46:38 -0500
From: John M Flinchbaugh <john@hjsoft.com>
To: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Thinkpad R40 freezes after swsusp resume
Message-ID: <20050210124636.GA10677@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I can suspend my R40 with swsusp, then boot it and resume fine most of
the time.

I'd say nearly 50$ of the time though, the machine will freeze within 5
minutes of resuming.

SysRq doesn't work, no oops when in console mode, no network, no disk=20
activity, just frozen.  Occassionally, I've seen a line or 2 of=20
pixels on my X screen get corrupted.

Here are some of the things I've tried adjusting:
pci=3Drouteirq.
pci=3Dnoacpi (or whatever it is).
shutting down hotplug over suspend to disable USB.
disabling cpudynd and CPU frequency scaling.
=2E..and probably a few other things i'm forgetting.
enabling lapic seemed to almost make it worse.

is any common hardware or subsystems on these machines known to not
suspend and resume properly?  i never see these freezes on a clean boot,
and if the machine survives 10 minutes after a resume, i'll not see it
freeze either.  i've witnessed this with every kernel, since i got the
machine in september (2.6.8.1, 2.6.9, 2.6.10, 2.6.11-rc3).

and finally, i know no one's had answers for me on this yet, so what
can i do to locate the problem and debug this myself?  is there a way to
get past these lockups to at least get a call trace to see where i'm
stuck?

thank you everyone.
--=20
John M Flinchbaugh
john@hjsoft.com

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCC1esCGPRljI8080RAme9AKCRXWB4AmhbYWrnEVej7uTM0YilIQCgg887
6AeulYVe19GiMGqjJ9KzrCI=
=CkxU
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
