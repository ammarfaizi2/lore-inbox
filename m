Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbUKDMUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbUKDMUd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbUKDMT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:19:56 -0500
Received: from dialin-212-144-166-213.arcor-ip.net ([212.144.166.213]:15806
	"EHLO karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S262191AbUKDMOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:14:52 -0500
In-Reply-To: <ik4HgxjQ.1099559539.9911850.khali@gcu.info>
References: <ik4HgxjQ.1099559539.9911850.khali@gcu.info>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-46-1004182221"
Message-Id: <1214282D-2E5B-11D9-BF00-000A958E35DC@fhm.edu>
Content-Transfer-Encoding: 7bit
Cc: "LKML" <linux-kernel@vger.kernel.org>, "Andi Kleen" <ak@suse.de>
From: Daniel Egger <degger@fhm.edu>
Subject: Re: dmi_scan on x86_64
Date: Thu, 4 Nov 2004 13:14:26 +0100
To: "Jean Delvare" <khali@linux-fr.org>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-46-1004182221
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 04.11.2004, at 10:12, Jean Delvare wrote:

> I think I also remember of a board where fan inputs were somehow
> multiplexed (the board had six fan headers, all of them reported speeds
> in the BIOS setup screen, but the hardware monitoring chip would only
> have three tachometers inputs.) I can't seem to remember the brand and
> model, and we did not investigate the problem deep enough to propose a
> solution back then anyway.

The sensors conf for the S2875 provided by Tyan only displays
3 FAN RPM values while the board has at least 4. At the moment I'm
using 3 fans with tacho signal but can only determine 2 values, the
third value is constantly 0.

Also the setup puzzles me a bit; why would Tyan pack several SMBus
setups into a single motherboard but only connect devices to one
of them. Actually sensors-detect claims that there is one
unrecognized client on the "unused" SMBus.

Servus,
       Daniel

--Apple-Mail-46-1004182221
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQYodIjBkNMiD99JrAQKmHQgAnHpospp8BPOHyeJp3bqtTpbSV5fJpnGU
icW5H2Kk8Ezv5D8LRnYcMFhhgQiN4mxFrBTBxY3BBzu6ssbgrZVQ7YMO/4eCp2Ta
C4k6gGFCYMbe7eKSIPpsbv4nxUwTk2PTgtKaQ8LG1FmV8G4aQ4pGLKyWlKgpY7hq
ZTQObAvZMJM259D4mcjFAL8jauXX0/KiiE8ghseD6ph9d7BEXsjxTjzAOtjRtJC4
NiLsJlUNoB+7KE9Yt+xNFdQhtt2n5cMOpTgJkSHgALiJeciZrpeqP1QR9R4ISY30
igJujEAJjmx1wr5ZZ/SAVFwyA5BOE/Z8066gnVizFO3iuVitrtYJsw==
=4GR5
-----END PGP SIGNATURE-----

--Apple-Mail-46-1004182221--

