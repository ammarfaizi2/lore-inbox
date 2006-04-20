Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWDTS2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWDTS2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWDTS2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:28:12 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:5551 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750726AbWDTS2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:28:10 -0400
X-Sasl-enc: Eh0LxwK6xWW5EOtz6XRPtz3EdhGLE4/hxswdwE52eAoH 1145557652
Message-ID: <4447D2F9.9070008@imap.cc>
Date: Thu, 20 Apr 2006 20:29:13 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org, kkeil@suse.de,
       i4ldeveloper@listserv.isdn4linux.de, linux-kernel@vger.kernel.org,
       hjlipp@web.de, gregkh@suse.de, linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.6 Patch] isdn4linux: Siemens Gigaset base driver: fix disconnect
 handling
References: <200604191838.k3JIc1eX022982@lx1.pxnet.com> <20060420001106.23d08ca7.akpm@osdl.org> <4447796F.1070307@imap.cc> <20060420082120.57ae9ac5.rdunlap@xenotime.net> <20060420153236.GU25047@stusta.de>
In-Reply-To: <20060420153236.GU25047@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF3B58DA0C89EDDC7487D630F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF3B58DA0C89EDDC7487D630F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20.04.2006 17:32, Adrian Bunk wrote:

> On Thu, Apr 20, 2006 at 08:21:20AM -0700, Randy.Dunlap wrote:
[...]
>>>>Tilman Schmidt <tilman@imap.cc> wrote:
>>>>
>>>>>--- linux-2.6.17-rc2-work/drivers/isdn/gigaset.orig/bas-gigaset.c	20=
06-04-19 15:15:49.000000000 +0200
>>>>>+++ local/drivers/isdn/gigaset/bas-gigaset.c	2006-04-19 01:19:41.000=
000000 +0200
>>
>>Both filename lines should begin one level above "drivers/".
>>They can be named linux* or a/ and b/ or foo/ and bar/ or whatever.
>>The patch needs to apply using "patch -p1".

Well, so it does.

> The only thing that is wrong is
>   linux-2.6.17-rc2-work/drivers/isdn/gigaset.orig/bas-gigaset.c
>                                             ^^^^^

I see. I'll avoid that in the future.

Randy.Dunlap again:

>> This is all well-documented.  Please review:
>>=20
>> linux-2.6.current/Documentation/SubmittingPatches
>> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
>> http://linux.yyz.us/patch-format.html
>>=20
>> and let us know if anything there needs to be clarified.

What wasn't obvious to me from these documents is that the "---" path
must also be "-p1 conforming" (so to say), as the "patch -p1" command
itself only requires that for the "+++" path.

Unfortunately I can't think of a wording that would have prevented that
misunderstanding for me. Perhaps a native English speaker might come up
with something.

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigF3B58DA0C89EDDC7487D630F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFER9MBMdB4Whm86/kRAp3jAJ4jr8JOVkl9CZB1h7WMDfPu5PISFQCdGsFB
foj72GLvNbgsdy7LxC9Axa0=
=P85b
-----END PGP SIGNATURE-----

--------------enigF3B58DA0C89EDDC7487D630F--
