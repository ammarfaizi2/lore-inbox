Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUFCWsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUFCWsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUFCWsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 18:48:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:32938 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264502AbUFCWsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 18:48:05 -0400
Date: Thu, 3 Jun 2004 21:30:16 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603193016.GC4879@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org>
X-Operating-System: Linux 2.6.5-14-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Wed, Jun 02, 2004 at 02:13:13PM -0700, Linus Torvalds wrote:
> Just out of interest - how many legacy apps are broken by this? I assume=
=20
> it's a non-zero number, but wouldn't mind to be happily surprised.
>=20
> And do we have some way of on a per-process basis say "avoid NX because
> this old version of Oracle/flash/whatever-binary-thing doesn't run with
> it"?

That's why the PT_GNU_STACK section is searched for ;-)
If it's not found, we assume a legacy app and go with the arch default.
I tested this -- on x86-64.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAv3xIxmLh6hyYd04RAgcYAJ4lNvofugo3B40zKYcUCr8oJV0fZgCeIyrf
i4fGakyArIXcdmiM96D1Mo4=
=u5kU
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
