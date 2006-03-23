Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWCWVPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWCWVPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWCWVPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:15:20 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:63377 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964954AbWCWVPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:15:18 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: separate swap-writing/reading code
Date: Fri, 24 Mar 2006 07:13:36 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Rafael Wysoki <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>
References: <200603231702.k2NH2OSC006774@hera.kernel.org>
In-Reply-To: <200603231702.k2NH2OSC006774@hera.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2054868.jyMiMfY8MF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603240713.41566.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2054868.jyMiMfY8MF
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 24 March 2006 03:02, Linux Kernel Mailing List wrote:
> commit 61159a314bca6408320c3173c1282c64f5cdaa76
> tree 8e1b7627443da0fd52b2fac66366dde9f7871f1e
> parent f577eb30afdc68233f25d4d82b04102129262365
> author Rafael J. Wysocki <rjw@sisk.pl> Thu, 23 Mar 2006 19:00:00 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Thu, 23 Mar 2006 23:38:07
> -0800
>
> [PATCH] swsusp: separate swap-writing/reading code
>
> Move the swap-writing/reading code of swsusp to a separate file.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>

I guess I missed this one somehow. Using a bitmap for allocated swap is rea=
lly=20
inefficient because the values are usually not fragmented much. Extents wou=
ld=20
have been a far better choice.

Regards,

Nigel

--nextPart2054868.jyMiMfY8MF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEIw+FN0y+n1M3mo0RAjZmAKDk2gZteobRt2z81w3OL0RHJCHmTgCgt96I
i+fYOZdVLxD0nXCaS/dlT7k=
=UqLs
-----END PGP SIGNATURE-----

--nextPart2054868.jyMiMfY8MF--
