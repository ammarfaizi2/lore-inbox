Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263078AbVBCU14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbVBCU14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVBCUZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:25:04 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:10178 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263813AbVBCUWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 15:22:51 -0500
Message-ID: <4202876F.3010302@kolivas.org>
Date: Fri, 04 Feb 2005 07:19:59 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <200502031420.j13EKwFx005545@localhost.localdomain>
In-Reply-To: <200502031420.j13EKwFx005545@localhost.localdomain>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig57F44CD8DAD584BFBD42626B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57F44CD8DAD584BFBD42626B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Davis wrote:
> 	* real inter-process handoff. i am thinking of something like
> 	    sched_yield(), but it would take a TID as the target
> 	    of the yield. this would avoid all the crap we have to 
> 	    go through to drive the graph of clients with FIFO's and
> 	    write(2) and poll(2). Futexes might be a usable
> 	    approximation in 2.6 (we are supporting 2.4, so we can't
> 	    use them all the time)

yield_to(tid) should not be too hard to implement. Ingo? What do you think?

Con

--------------enig57F44CD8DAD584BFBD42626B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCAodvZUg7+tp6mRURAiE+AJwM9sygfYG2myleIAt4x99ldnormgCfe3qW
uabXqJ539bxiDUn/rFi40UE=
=Cfgr
-----END PGP SIGNATURE-----

--------------enig57F44CD8DAD584BFBD42626B--
