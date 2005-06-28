Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVF1Asx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVF1Asx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVF1Asx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:48:53 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:58070 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262213AbVF1Ass (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:48:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] sched: consider migration thread with smp nice
Date: Tue, 28 Jun 2005 10:48:25 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@aracnet.com>
References: <200506261825.19740.kernel@kolivas.org> <42C09D31.5030207@bigpond.net.au>
In-Reply-To: <42C09D31.5030207@bigpond.net.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1737584.kY5TFBqiYa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506281048.29674.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1737584.kY5TFBqiYa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 28 Jun 2005 10:43, Peter Williams wrote:
> Con Kolivas wrote:
> > This patch improves throughput with the smp nice balancing code. Many
> > thanks to Martin Bligh for the usage of his regression testing bed to
> > confirm the effectiveness of various patches.
>
> Con,
> 	This doesn't build on non SMP systems due to the migration_thread field
> only being defined for SMP.  Attached is a copy of a slightly modified
> PlugSched version of the patch which I used to fix the problem in
> PlugSched.  Even though it's for a different file it should be easy to
> copy over.

Peter

Look at the actual patch I sent out you'll see it moved the ifdefs up to=20
compensate. I believe your port of my patch doesn't build and I suspect it'=
s=20
because you missed these ifdef movements ;)

Cheers,
Con

--nextPart1737584.kY5TFBqiYa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCwJ5dZUg7+tp6mRURAhfLAJ0dmhYOpQn72r79P910nReZFCU5vACfUhst
SE+0Ya+t7U7exzZ4DM2SoD8=
=FL1L
-----END PGP SIGNATURE-----

--nextPart1737584.kY5TFBqiYa--
