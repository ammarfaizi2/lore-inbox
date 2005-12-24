Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161166AbVLXGnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161166AbVLXGnj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 01:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVLXGnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 01:43:39 -0500
Received: from pv105234.reshsg.uci.edu ([128.195.105.234]:47561 "HELO
	pv105234.reshsg.uci.edu") by vger.kernel.org with SMTP
	id S932510AbVLXGnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 01:43:39 -0500
Message-ID: <43ACEE14.7060507@feise.com>
Date: Fri, 23 Dec 2005 22:43:32 -0800
From: Joe Feise <jfeise@feise.com>
Reply-To: jfeise@feise.com
Organization: feise.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20051025 Thunderbird/1.5 Mnenhy/0.7.3.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mouse issues in 2.6.15-rc5-mm series
X-Enigmail-Version: 0.93.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE91DBA78C7D59CBE9AA968A9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE91DBA78C7D59CBE9AA968A9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[Note: please cc me on answers since I'm not subscribed to the kernel lis=
t]

I am experiencing problems with mouse resyncing in the -mm series.
This is a Logitech wheel mouse connected through a KVM.
Symptom: whenever the mouse isn't moved for some seconds, it doesn't
react to movement for a second, and then resyncs. Sometimes, the
resyncing results in the mouse pointer jumping, which as far as I
know is a protocol mismatch.
While searching for reports of similar problems, I came across
Frank Sorenson's post from Nov. 23 (http://lkml.org/lkml/2005/11/23/533).=

Like in his case, reverting
input-attempt-to-re-synchronize-mouse-every-5-seconds.patch
resulted in a kernel without this problem.

-Joe





--------------enigE91DBA78C7D59CBE9AA968A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFDrO4UKc8oZ1MoTeoRAriIAKC1kITqea9ei+PIqfcedJz/ECdFCwCgna9+
XX74ooa+/O0UWK40gxOXzCA=
=7Lu1
-----END PGP SIGNATURE-----

--------------enigE91DBA78C7D59CBE9AA968A9--
