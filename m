Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVCCKau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVCCKau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVCCKat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:30:49 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:40418 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S262440AbVCCK3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:29:13 -0500
Message-ID: <4226E6F3.2030803@arcor.de>
Date: Thu, 03 Mar 2005 11:29:07 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050222)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <200503022121.07679.gene.heskett@verizon.net>
In-Reply-To: <200503022121.07679.gene.heskett@verizon.net>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig56081C1091880B6892F875A2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig56081C1091880B6892F875A2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gene Heskett schrieb:
> On Wednesday 02 March 2005 20:15, Linus Torvalds wrote:
>
>>On Wed, 2 Mar 2005, Greg KH wrote:
>>
>>>I think this statement proves that the current development
>>>situation is working quite well.  The nasty breakage and details
>>>got worked out in the -mm tree, and then flowed into your tree
>>>when they seemed sane.
>>
>>Actually, the breakage I was talking about got fixed in _my_ tree.
>>
>>I'd love for the -mm tree to get more testing, but it doesn't.
>>
>
> Well, that might change if, when I came crying to the list about
> something thats broken in an -mm release, I wasn't chased off to go
> run a "more stable" release.  Thats occured 2-3 times in the past
> year.


A gentoo view: There are lots of patchsets floating around in the gentoo forum
based on either vanilla or mm-kernel, but over the months something has
changed: Previously most patchsets were based on mm, but now are based on
vanilla. Why? Very simple: mm became too unstable. I used to go with a mm
based kernel just for fun, but it changed as one kernel had some serious
issues with reiserfs - and it is really not fun to lose data. (At least I read
about it, before testing that kernel.) Since then i never touched a mm-kernel
again, in fact now I even feel scared to put on a vanilla-rc kernel. I do it,
but I feel like when I use a "stable" mm-kernel from earlier times...

So if you wantpeople to test kernels, they shouldn't be too unstable...

And if you want bug reports, make it easier for the user. I know there is a
txt file in the kernel src dir, but it would be better, if there would be a
complete script which gets all possible need infos itself. Then user driven
input could be minimized.

Furthermore many users are simple afraid to post to lkml. (They report to
forums, but don't want to report to lkml.) Even I often tend to think: Ok, I
came across a small bug. Should I post it or should I wait till next rc?
Usually I wait, because I feel like getting on people's nerves when I post
every little tidbit. Esp if bugreports seem to get ignored motivation goes
down to report again...

Nevertheless, for a fun loving desktop user, I enjoy the pace the linux kernel
is evolving. It was so "boring" the 2.4 days. But on the other hand linux
kernel now tends to break various things with each release. I think esp nvidia
users now about it...

Cheers

--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enig56081C1091880B6892F875A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCJub3xU2n/+9+t5gRAtgHAJ9EjKtzU2wZofPmw1g3BOCxugkz5wCg0754
L620LMXVtH36QA7i9hN++sk=
=dbCa
-----END PGP SIGNATURE-----

--------------enig56081C1091880B6892F875A2--
