Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVAPEBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVAPEBf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbVAPEBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:01:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65170 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262414AbVAPEB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:01:29 -0500
Message-ID: <41E9E65F.1030100@redhat.com>
Date: Sat, 15 Jan 2005 19:58:23 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: short read from /dev/urandom
References: <41E7509E.4030802@redhat.com> <20050116024446.GA3867@waste.org>
In-Reply-To: <20050116024446.GA3867@waste.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig496E3564E07059494AD7EF1B"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig496E3564E07059494AD7EF1B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Matt Mackall wrote:
> _Neither_ case mentions signals and the "and will return as many bytes
> as requested" is clearly just a restatement of "does not have this
> limit". Whoever copied this comment to the manpage was a bit sloppy
> and dropped the first clause rather than the second:

It still means the documented API says there are no short reads.


> So anyone doing a read() can expect a short read regardless of the fd
> and is quite clear that reads can be interrupted by signals. "It is
> not an error". Ever.

Of course are signal interruptions wrong if the signal uses SA_RESTART.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

--------------enig496E3564E07059494AD7EF1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB6eZf2ijCOnn/RHQRAvNoAJ0cZB+WFZUEfaUmLhoFjFR/zfhRzQCfR4Kw
DubpVw0k8L5oQkGnt3kTEuk=
=P971
-----END PGP SIGNATURE-----

--------------enig496E3564E07059494AD7EF1B--
