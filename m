Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVBLIbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVBLIbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 03:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVBLIbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 03:31:16 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:30427 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262401AbVBLIbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 03:31:14 -0500
Message-ID: <420DBEBE.1060008@t-online.de>
Date: Sat, 12 Feb 2005 09:30:54 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0 (X11/20050119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
References: <20050211004033.GA26624@suse.de> <420D1050.3080405@t-online.de> <20050211210114.GA21314@suse.de>
In-Reply-To: <20050211210114.GA21314@suse.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0E1E22F8368F85C4D2DBD4F5"
X-ID: SgDT-aZEZec3nIFMid1J68rskuVnPpNo2TuHKMFX6KlSUwOgmnCO4K
X-TOI-MSGID: 36484ad0-6af6-4ce3-baf5-4a25a3702cf1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0E1E22F8368F85C4D2DBD4F5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
>
> Because we don't have an easy way yet to build against a copy of klibc
> on a system?  For right now, it's the simplest way to ensure that it
> works for everyone, once klibc moves into the kernel tree I can remove
> it from udev and hotplug-ng.
>

If it is not possible to use klibc together with a non-Linux
system (e.g. FreeBSD or Mach), then I would suggest to make
klibc an optional kernel patch and drop it from udev and
hotplug.

> Is it causing problems for you?
>

Some months ago I had contributed a patch to add an install
target to the klibc Makefiles. I just wonder why it has been
ignored.


Regards

Harri

--------------enig0E1E22F8368F85C4D2DBD4F5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCDb7DUTlbRTxpHjcRAjy0AJoCK6k9ANY0IKN9RA74hUmr8nCrqgCfc89w
D9h4zqgd0/FlG07H+6QS43g=
=azBJ
-----END PGP SIGNATURE-----

--------------enig0E1E22F8368F85C4D2DBD4F5--
