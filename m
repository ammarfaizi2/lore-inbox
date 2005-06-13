Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVFMKGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVFMKGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 06:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVFMKF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 06:05:59 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:20122 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261456AbVFMKFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 06:05:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC] blkstat
Date: Mon, 13 Jun 2005 20:05:38 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <42AD55FA.50109@yahoo.com.au> <200506131954.45361.kernel@kolivas.org> <42AD59A9.3030404@yahoo.com.au>
In-Reply-To: <42AD59A9.3030404@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1414827.AYvoMQYZNW";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506132005.40846.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1414827.AYvoMQYZNW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 13 Jun 2005 20:02, Nick Piggin wrote:
> Con Kolivas wrote:
> > On Mon, 13 Jun 2005 19:46, Nick Piggin wrote:
> >>Oh, and before I go further, does anyone know of any program
> >>or statistic that allows the same functionality? Any comments?
> >
> > Would something like iostat give similar results?
>
> The problem with that is that it does not give you a % idle
> figure on the block device, so you basically can't see if
> the device is becoming a bottleneck.

I've often wondered how iostat gives a %busy figure and whether this=20
translated accurately without further info from the kernel.

> You can kind of guess if you take into account the seeks,
> and the throughput, but you're still missing things like
> head position (eg. changes throughput), settle time and
> rotational latency, and lots of other stuff.
>
> Thanks,
> Nick
>
> Also, BTW. the way I have done the kernel patch make a
> device show 100% utilisation even if it is not doing anything
> but waiting for a plug, or an anticipatory scheduler. This
> is basically all the end user wants to know, although for
> development purposes it may be interesting to know the other
> metric too.

That sounds quite useful.

Cheers,
Con

--nextPart1414827.AYvoMQYZNW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCrVp0ZUg7+tp6mRURAr6UAKCIUtCCN4fEsrO9FGiEc2iqQpwtVwCfV33N
CeQ3+sG0Y9FzxlkKBxDSHSc=
=hIv4
-----END PGP SIGNATURE-----

--nextPart1414827.AYvoMQYZNW--
