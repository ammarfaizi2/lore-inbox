Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTJQD2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 23:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTJQD2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 23:28:55 -0400
Received: from mcgroarty.net ([64.81.147.195]:32219 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S263299AbTJQD2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 23:28:54 -0400
Date: Thu, 16 Oct 2003 22:24:36 -0500
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc reliability & performance
Message-ID: <20031017032436.GA17480@mcgroarty.net>
References: <1066356438.15931.125.camel@cube>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <1066356438.15931.125.camel@cube>
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2003 at 10:07:18PM -0400, Albert Cahalan wrote:
> I created a process with 360 thousand threads,
> went into the /proc/*/task directory, and did
> a simple /bin/ls. It took over 9 minutes on a
> nice fast Opteron. (it's the same at top-level
> with processes, but I wasn't about to mess up
> my system that much)

Are there many cases where the /proc directory contents are read in
this fashion?

I'd be more curious about how performance fares with reading a
thousand entries by name with 1k processes and with 360k processes.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/j2D02PBacobwYH4RArpcAJ9EAHWTIBoC5rUZ3fZ/Ev0dCSg1AwCePWH8
VDX0luD0yKcnc4u2qWV3Jr0=
=VkDF
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
