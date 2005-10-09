Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVJIU5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVJIU5b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 16:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVJIU5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 16:57:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:15249 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932215AbVJIU5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 16:57:30 -0400
X-Authenticated: #815327
Message-ID: <43498432.8060503@gmx.de>
Date: Sun, 09 Oct 2005 22:57:22 +0200
From: =?ISO-8859-1?Q?Malte_Schr=F6der?= <MalteSch@gmx.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <Trond.Myklebust@netapp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with nfs4, kernel 2.6.13.2
References: <200509251516.23862.MalteSch@gmx.de> <1127737730.8453.5.camel@lade.trondhjem.org> <200509262218.15885.MalteSch@gmx.de>
In-Reply-To: <200509262218.15885.MalteSch@gmx.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6D34275F9158FAA78BFAF25E"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6D34275F9158FAA78BFAF25E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Malte Schr=F6der wrote:
> On Monday 26 September 2005 14:28, Trond Myklebust wrote:
>=20
>>Also, is this something that is NFSv4 only, or can you reproduce it on
>>NFSv2/v3 too?
>=20
>=20
> I have been running my "stress test" for a few hours with nfsv3, withou=
t=20
> problems.
> I tried over nfsv4 again and it crashed after a few minutes.
>=20

I had time to try this with 2.6.12.5, I was not able to reproduce the
error there.
I also found the following post on LKML:

Bret Towe wrote:
> On 9/8/05, Bret Towe <magnade@gmail.com> wrote:
>
>>On 9/6/05, J. Bruce Fields <bfields@fieldses.org> wrote:
>>
>>>On Mon, Sep 05, 2005 at 08:40:53PM -0700, Bret Towe wrote:
>>>
>>>>Pid: 14169, comm: xmms Tainted: G   M  2.6.13
>>>
>>>Hm, can someone explain what that means?  A proprietary module was
>>>loaded then unloaded, maybe?
>>>
>>>You may also want to retest with
>>>
>>>http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.13-1=
/linux-2.6.13-001-NFS_ALL_MODIFIED.dif
>>>
>>>applied, to make sure there isn't a patch in Trond's series that alrea=
dy
>>>fixes the bug.
>>>
>>>--b.
>>>
>>
>>ive been running this since i got the url and so far i havent hit it
>>ive also been a bit busy so i havent been able to make sure its good
>>this weekend i should be able to test it and make sure its solved
>>
>
> ran it pretty hard over the weekend and i had no crashs at all
> so i think its safe to say this patch fixes the issues i was seeing

The above server is currently unreachable from my part of the net but
Bret Towe seemed to have the same problem as I have. Since the problem
also appears when using 2.6.14-rc3 I think the patch should be looked at
and maybe considered for inclusion. As soon as I gain access to that
patch I will test it and report my results.


--------------enig6D34275F9158FAA78BFAF25E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDSYQ44q3E2oMjYtURAkcDAJ9SgRqGjnJRHEy+EGcdktUIA/mdyACgmEpQ
SnvltH69ItXiJJ5UXY75GJM=
=jbEQ
-----END PGP SIGNATURE-----

--------------enig6D34275F9158FAA78BFAF25E--
