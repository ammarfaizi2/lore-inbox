Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbULNWdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbULNWdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULNWco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:32:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261732AbULNW1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:27:51 -0500
Message-ID: <41BF6879.3090900@redhat.com>
Date: Tue, 14 Dec 2004 14:26:01 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Roland McGrath <roland@redhat.com>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
References: <200412142150.iBELoJc0011582@magilla.sf.frob.com> <Pine.LNX.4.58.0412141410150.3279@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0412141410150.3279@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC818FD6CC6B01DD11220807F"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC818FD6CC6B01DD11220807F
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Linus Torvalds wrote:
> I'd vote for
> not exposing them any more than necessary (ie the current incidental "ps"  
> interface is quite enough), at least until somebody can come up with a
> very powerful example of why exposing them is a good idea.

Indeed.  It's so much easier to grant additional rights at a later time 
than to take something away for whatever reasons.

Globally accessible clocks would need to have the semantic carefully 
defined, SELinux hooks would have to be added etc.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

--------------enigC818FD6CC6B01DD11220807F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBv2h62ijCOnn/RHQRAn4UAJ9TpHpEnEY1HYa9umF5uVM3e96hngCfXXXZ
5C+jr8chehvIj5x60D0DLhg=
=Y0Xp
-----END PGP SIGNATURE-----

--------------enigC818FD6CC6B01DD11220807F--
