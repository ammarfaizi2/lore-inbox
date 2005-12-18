Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVLRPXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVLRPXY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbVLRPXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:23:24 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:40116 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965116AbVLRPXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:23:23 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 No Idle HZ aka dynticks 051217
Date: Mon, 19 Dec 2005 02:22:37 +1100
User-Agent: KMail/1.9
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Petrini <d.pensator@gmail.com>, Tony Lindgren <tony@atomide.com>,
       vatsa@in.ibm.com, ck list <ck@vds.kolivas.org>,
       Pavel Machek <pavel@ucw.cz>, Adam Belay <abelay@novell.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
References: <200512190219.40631.kernel@kolivas.org>
In-Reply-To: <200512190219.40631.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1143537.1ldKsETfQD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512190222.40399.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1143537.1ldKsETfQD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 19 December 2005 02:19, Con Kolivas wrote:
> Here is yet another updated version of the dynticks code.
>
> Changes:
>
> Numerous cleanups, microoptimisations and locking improvements.
>
> One bugfix for the next tick accounting used in early_dyn_reprogram
>
> I've yet to find the cause for grossly high cpu accounting on SMP. I'd
> appreciate any help in this area as it's the last showstopper for this
> code.
>
> Obvious power savings are evident on uniprocessor now in on/off comparisons
> using pmstats.

That would be dynticks-051218 I mean, sorry.

Cheers,
Con

--nextPart1143537.1ldKsETfQD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDpX7AZUg7+tp6mRURAsivAJ0fReHZPyI5zL2z2EdVar9N5ZKcVQCfaJV2
cAJh/ZYjepmMqWtjY1xjPC4=
=JVRn
-----END PGP SIGNATURE-----

--nextPart1143537.1ldKsETfQD--
