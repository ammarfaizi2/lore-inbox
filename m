Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTLKOuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTLKOuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:50:14 -0500
Received: from itaqui.terra.com.br ([200.176.3.19]:38293 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S265061AbTLKOuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:50:03 -0500
Date: Thu, 11 Dec 2003 12:49:12 -0400
From: Rhino <rhino9@terra.com.br>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>,
       wli@holomorphy.com
Subject: Re: [CFT][RFC] HT scheduler
Message-Id: <20031211124912.1c7e97e8.rhino9@terra.com.br>
In-Reply-To: <3FD82775.3050303@cyberone.com.au>
References: <3FD3FD52.7020001@cyberone.com.au>
	<20031208155904.GF19412@krispykreme>
	<3FD50456.3050003@cyberone.com.au>
	<20031209001412.GG19412@krispykreme>
	<3FD7F1B9.5080100@cyberone.com.au>
	<3FD81BA4.8070602@cyberone.com.au>
	<20031211060120.4769a0e8.rhino9@terra.com.br>
	<3FD82775.3050303@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__11_Dec_2003_12_49_12_-0400_3bqn=OOCW.LYL_cP"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__11_Dec_2003_12_49_12_-0400_3bqn=OOCW.LYL_cP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 11 Dec 2003 19:14:45 +1100
Nick Piggin <piggin@cyberone.com.au> wrote:

> You won't be able to merge mine with Ingo's. Which one put the box on
> steroids? :)

sorry if i wasn't clearly enough, but i merged each one of them separately on top of a wli-2. 
that comment was for the wli changes. :)

> Wonder whats going on here? Is this my patch vs Ingo's with nothing else 
> applied?
> How does plain 2.6.0-test11 go?
> 
> Thanks for testing.


ok, this time on a plain test11.

hackbench:

		w26						sched-SMT-C1

	 50	 5.026				 50	 5.182
	100	10.062				100	10.602
	150	15.906				150	16.214


time tar -xvjpf linux-2.6.0-test11.tar.bz2:

		w26						sched-SMT-C1
		
	real	0m21.835s			real	0m21.827s
	user	0m20.274s			user	0m20.412s
	sys	0m4.178s				sys	0m4.260s

--Signature=_Thu__11_Dec_2003_12_49_12_-0400_3bqn=OOCW.LYL_cP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2KARP7/1py/aJRgRAjh3AKCK72WjeD1Iz9v2pjNXvAB+YvGb7gCbBWCD
Tcz0yCCCSFtxgqvfG+hBxTo=
=DYgv
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Dec_2003_12_49_12_-0400_3bqn=OOCW.LYL_cP--
