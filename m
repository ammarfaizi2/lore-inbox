Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUCPPzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbUCPPzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:55:16 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:28128 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263156AbUCPPxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:53:34 -0500
Date: Tue, 16 Mar 2004 17:46:11 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: Process priority fed back to parent?
Message-ID: <20040316154611.GA31510@mulix.org>
References: <40571A62.8050204@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <40571A62.8050204@techsource.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2004 at 10:16:50AM -0500, Timothy Miller wrote:

> This way, after gcc has run a few times, it'll be flagged as a CPU-bound=
=20
> process and every time it's run after that point, it is always run at an=
=20
> appropriate priority.  Similarly, the first time xmms is run, its=20
> interactivity estimate won't be right, but after it's determined to be=20
> interactive, then the next time the program is launched, it STARTS with=
=20
> an appropriate priority:  no ramp-up time.

This is something that I've thought of doing in the past. The reason I
didn't pursue it further is that it's impossible to get it right for
all cases, and it attacks the problem in the wrong place. The kernel
shouldn't need to guess(timate) what the process is going to do. The
userspace programmer, who knows what his process is going to do,
should tell the kernel.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVyFDKRs727/VN8sRAkihAJ4lSal7HhpKproA5N7UXqzmR8pOlwCfTlr+
FJHwhoaQERk+x5aqzatbJTI=
=zpno
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
