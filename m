Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUCPQPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbUCPQMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:12:23 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:26244 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263262AbUCPQKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:10:09 -0500
Date: Tue, 16 Mar 2004 18:02:46 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: Process priority fed back to parent?
Message-ID: <20040316160246.GL28008@mulix.org>
References: <40571A62.8050204@techsource.com> <20040316154611.GA31510@mulix.org> <40572922.10109@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z/kiM2A+9acXa48/"
Content-Disposition: inline
In-Reply-To: <40572922.10109@techsource.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Z/kiM2A+9acXa48/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 16, 2004 at 11:19:46AM -0500, Timothy Miller wrote:

> Unfortunately, the OS has to play babysitter to processes, because=20
> they're guaranteed to misbehave.  Preemption exists to ensure fairness=20
> amongst processes.  Thus, while you're right that it would be nice to=20
> have processes report their CPU requirements, if we were to actually DO=
=20
> that, it would be a disaster.

I agree we should do the best thing possible without any prior
knowledge of what a process should do. I don't agree we should add
pointless complexity to the scheduler for dubious gains (getting rid
of the very short ramp up time). Of course, if you think it's useful,
feel free to implement it and let's resume the discussion when we have
some numbers.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--Z/kiM2A+9acXa48/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVyUmKRs727/VN8sRAk72AJsHcNHFQps9hHkgh1WjZEix81uQ3gCgpWME
WxIhAdJdrQ/xcCvYWRD3q5A=
=SARE
-----END PGP SIGNATURE-----

--Z/kiM2A+9acXa48/--
