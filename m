Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbUBEFmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 00:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUBEFmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 00:42:12 -0500
Received: from adsl-67-124-158-125.dsl.pltn13.pacbell.net ([67.124.158.125]:44681
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S264374AbUBEFmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 00:42:10 -0500
Date: Wed, 4 Feb 2004 21:42:09 -0800
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc3-mm1 (i_sem)
Message-ID: <20040205054209.GF4394@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <1075822589.2341.2.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <1075822589.2341.2.camel@glass.felipe-alfaro.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2004 at 04:36:29PM +0100, Felipe Alfaro Solana wrote:
> i_size_write() called without i_sem
> Call Trace:
>  [<c013915d>] i_size_write_check+0x5b/0x5d
>  [<c0188dbc>] ext3_journalled_commit_write+0x11d/0x159
>  [<c0185cb6>] commit_write_fn+0x0/0x73
>  [<c016123e>] page_symlink+0xab/0x18d
>  [<c018c466>] ext3_symlink+0x145/0x185
>  [<c018c321>] ext3_symlink+0x0/0x185
>  [<c01601c2>] vfs_symlink+0x74/0xa8
>  [<c01602c9>] sys_symlink+0xd3/0xdf
>  [<c010b671>] do_IRQ+0x154/0x19d
>  [<c0314fc6>] sysenter_past_esp+0x43/0x65

Ooh, me too! A little differnet, though.

i_size_write() called without i_sem
Call Trace:
 [<c013b537>] i_size_write_check+0x57/0x60
 [<c018ccc0>] ext3_journalled_commit_write+0xb0/0x150
 [<c018ca10>] commit_write_fn+0x0/0x70
 [<c01656c5>] page_symlink+0xd5/0x1c9
 [<c0192cc1>] ext3_symlink+0x161/0x1a0
 [<c0164597>] vfs_symlink+0x57/0xb0
 [<c01646c1>] sys_symlink+0xd1/0xe0
 [<c0328b1b>] syscall_call+0x7/0xb

--=20
Joshua Kwan

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQIVAwUBQCHXr6OILr94RG8mAQL+JQ//ZceI6DACihqQ0ehUehoSRdRIW4OSCs/q
AqkVaIJlL+S53cr5Xw+FMSs2SQ5fIUhgG7GMk3dx8ZZVkdl9WlwHVhXKWrydk0+S
kpgj9lPK1hDKjsrgt1wEnb5Qo8CFbbJ8nCqSjV1BPXG7nc+rKDwsIfSOfnsM/Dnn
IX8SaGd/AaHUXRVSqp3fY22MFWSIUvp+QjDiLBEbJzn80LIdjFJlpxMp2nxYZgoW
cLAZqpV7T0zXFu5030JNdl5nhkMdYn7r/8FYN6vqjTBRt7QwqNiQskUQjAHZt4js
l2kcUC/oQsgcH0fRmQXNitHjvSsbVbpK+ZujCp3K0Z6FSLp7UEWJHMPleAOT2tuo
V6m8fWCAcxdp5EtyYr/4UL43Eg+R9hFmqMqhFnH0//ay+emHgxyDm6wV1BcJEJX9
w1uw1el8t7abdoQnJtsT6BZOb0KgwDB5R423+WfhCNy1ZASH2h1jPtU16iAtgT8+
hhvkQHQYLwjnRpegLz6JIuWiE5TZd/sC/5RVYIlEK2exL0S9Doy1tOUF3Yc+ZCDf
dNpLMj8JmO+CGKj1wk2+NFBPffwGbAgRfD9++MxzcFOQ3kHt/85VpciP4f+Bfsfl
2EdN7NCIUCXzePSwua3BAYLwP1+DMGUn0ydaV23I6rmzBfLPlnJQ0YeqNHkXRcRS
fdkIfUFQ584=
=YXHM
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
